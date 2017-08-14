或许这个题目起得有点太高调了，不过我只是想纠正一些童鞋对于autorelease的认识，如果能帮到几个人，那这篇文章也就值得了！当然，高手请绕道

本文主要探讨两个方面：（1）autorelease对象到底是合适被析构的？（2）OC内部是如何处理一个被autorelease掉的对象的？

（1）autorelease对象到底是何时被析构的？

这个问题说难不难，但说简单也不简单。我们还是先看一类熟悉的不能再熟悉的代码吧：

1 - (void)viewDidLoad {
2     [super viewDidLoad];
3     NSArray *localArr = [NSArray arrayWithObject:@"Weng Zilin"];//这是一个局部对象，封装了autorelease方法
4     }
请问，localArr这个局部变量何时被析构呢？很多人会回答：“出了作用域，也就是花括号之后就会被回收”。但遗憾的是，事实并非你想象的那般顺利。下面我通过几行代码向你证明，localArr出了作用于依旧活得好好的：（ARC环境下）

__weak id objTrace;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *localArr = [NSArray arrayWithObject:@"Weng Zilin"];//这是一个局部对象，封装了autorelease方法
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear__localArr:%@", objTrace);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewWillAppear__localArr:%@", objTrace);
}
在ARC环境下我用一个__weak类型来追踪localArr的释放时机，__weak并不会对localArr增加引用计数，因此不干扰其释放，log显示如下：



我们发现，localArr在viewWillAppear还活着，在DidAppear已经挂了。这说明了一件事：autorelease并不是根据作用域来决定释放时机的。那到底是依据什么呢？答案是：runloop。runloop不在本文讨论范围内，感兴趣的同学请自行查阅资料，传送门点这里。简单说，runloop就是iOS中的消息循环机制，当一个runloop结束时系统才会一次性清理掉被autorelease处理过的对象，其实本质上说是在本次runloop迭代结束时清理掉被本次迭代期间被放到autorelease pool中的对象的。至于何时runloop结束并没有固定的duration！

那么问题来了：iOS的这种基于runloop的内存回收策略有不方便的时候吗？我认为是显然有的。但凡事物总是有两面性的，使用autorelease的确方便，但在一定的情况下会带来性能问题。我们看个例，这个例子转载在我之前的文章：

for (int i = 0; i <= 1000; i ++) {
       //1.首先我们获取到需要处理的图片资源的路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"PNG"];
        //2.将图片加载到内存中，我们使用了alloc关键字，在使用完后，可以手动快速释放掉内存
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
       //3.这一步我们将图片进行了压缩，并得到一个autorelease类型实例
        self.image2 = [image imageByScalingAndCroppingForSize:CGSizeMake(480, 320)];
       //4.释放掉2步骤的内存
        [image release];
    }
上述例子看起来没有什么问题，因为一切都是按照MRC的规定做的，可以说是一种“看起来”十分规范的写法。但是主要到image2这个对象了没，赋值给image2对象的临时image对象是一个autorelease类型。实际去跑这段程序会发现，在循环1000次的条件下内存持续上升，因为那个autorelease对象并没有如我们预期般在每次for循环的花括号结束时释放掉！如果从runloop的角度考虑就显得合理了。

那么问题又来了：既然交给runloop处理不放心(runloop其实是有人类的“拖延症”的)，那我们可以人工干预autorelease对象的释放时机吗？答案是，欢天喜地，可以的。上文有提到autorelease pool，这是下一个问题要解决的任务，在这里不展开，你只需要知道，一旦一个对象被autorelease，则该对象会被放到iOS的一个池：autorelease pool，其实这个pool本质上是一个stack，扔到pool中的对象等价于入栈。我们把需要及时释放掉的代码块放入我们生成的autorelease pool中，结束后清空这个自定义的pool，主动地让pool清空掉，从而达到及时释放内存的目的。以上述图片处理的例子为例，优化如下：

 1 for (int i = 0; i <= 1000; i ++) {
 2  
 3        //创建一个自动释放池
 4         NSAutoreleasePool *pool = [NSAutoreleasePool new];//也可以使用@autoreleasePool{domeSomething}的方式
 5         NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"PNG"];
 6         UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
 7         UIImage *image2 = [image imageByScalingAndCroppingForSize:CGSizeMake(480, 320)];
 8         [image release];
 9        //将自动释放池内存释放，它会同时释放掉上面代码中产生的临时变量image2
10         [pool drain];
11     }
其中对pool的操作也可以等价地使用@autoreleasePool{domeSomeThing;}替代。以上就简要地回答了本文开始处抛出的第一个问题，小结一下就是：释放时机是基于runloop而不是作用域；通过autorelease pool手动干预释放；循环多次时当心要对autorelease进行优化。下面我们开始第二个问题的讨论

（2）一个对象被标记为autorelease后经历了怎么样的过程？

其实我认为这个问题讨论起来更有意思，因为它已经比较底层了。前面提到autorelease对象最终被放到autorelease pool中，那这个pool到底是何方神圣呢？当我们使用@autoreleasepool{}时，编译器实际上将其转化为以下代码：

void *context = objc_autoreleasePoolPush();
// {}中的代码
objc_autoreleasePoolPop(context);//当前runloop迭代结束时进行pop操作
而objc_autoreleasePoolPush与objc_autoreleasePoolPop又是什么呢？他们只是对autoreleasePoolPage的一层简单封装，下面是autoreleasePoolPage的结构，它是C++数据类型，本质是一个双向链表。next就是指向当前栈顶的下一个位置。



里面还有各种参数，不过记住这句话就行：向一个对象发送- autorelease消息，就是将这个对象加入到当前AutoreleasePoolPage的栈顶next指针指向的位置。

在文章的最后顺便提一下，在iOS中有三种常用的遍历方法：for、forin、enumerateObjectsUsingBlcok。实际使用中大家可能没有感觉到又什么区别，前面两个比较常用，最后一个是iOS特有的遍历方式，但事实上还是有区别的。block版本的遍历方式已经内嵌了@autoreleasepool{}操作，而前面两个没有，这样就意味着使用block版本的遍历方式会使app更加健壮，内存使用效率更加出色，而且，逼格更高，嘿嘿！

