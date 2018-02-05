//
//  ViewController.m
//  柏拉图
//
//  Created by 肖朝阳 on 2017/11/26.
//  Copyright © 2017年 肖朝阳. All rights reserved.
//

#import "ViewController.h"
#define colonumWidth  40.0
#define rowHeight  20
#define scaleTitleFont 20

// 33.33-270 = 236.67  60-270=210  80-270=190 93.33-270=176.67  100-270=170
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *colorArray = @[].mutableCopy;
    [colorArray addObject:[UIColor colorWithRed:255.0/255 green:81.0/255 blue:151.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:79.0/255 green:255.0/255 blue:109.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:100.0/255.0 green:255.0/255 blue:234.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:97.0/255 green:168.0/255 blue:255.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:111.0/255 green:99.0/255 blue:255.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:196.0/255 green:84.0/255 blue:255.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:255.0/255 green:70.0/255 blue:255.0/255 alpha:1]];
    [colorArray addObject:[UIColor colorWithRed:97.0/255 green:60.0/255 blue:255.0/255 alpha:1]];
    NSArray *rateTitleArray = @[@"",@"35.56%",@"62.22%",@"80%",@"88.89%",@"95.56%",@"100%"];
    NSArray *countArray = @[@16,@12,@8,@4,@3,@2];
    NSArray *rowTitle = @[@"测量方法的误差",@"穿刺部位选择不正确",@"病人心情紧张",@"穿刺技术不熟练",@"病人静脉血管差",@"其他"];
    float originX = 40;
    float originY = 60;
    UIView *leftLine = [[UIView alloc] init];
    leftLine.frame = CGRectMake(67, originY+10, 1, rowHeight*10);
    leftLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftLine];
    float lastY = 0.0;
    float rightX = 0.0;
    for (int i=0; i<11; i++) {
        UILabel *leftlabel = [[UILabel alloc] init];
        leftlabel.font = [UIFont systemFontOfSize:10];
        leftlabel.text = [NSString stringWithFormat:@"%.1f",(10-i)*5*0.9];
        leftlabel.frame = CGRectMake(originX, originY+rowHeight*i, 24, scaleTitleFont);
        leftlabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:leftlabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        line.frame = CGRectMake(CGRectGetMaxX(leftlabel.frame)+5, CGRectGetMidY(leftlabel.frame), colonumWidth*countArray.count+4, 0.5);
        [self.view addSubview:line];
        
        lastY = CGRectGetMaxY(line.frame);
            UILabel *rightLabel = [[UILabel alloc] init];
            rightLabel.font = [UIFont systemFontOfSize:10];
            rightLabel.text = [NSString stringWithFormat:@"%.2f%%",(100.0-10*i)];
            rightLabel.textAlignment = NSTextAlignmentLeft;
            rightLabel.frame = CGRectMake(CGRectGetMaxX(line.frame)+5, originY+rowHeight*i, 60, scaleTitleFont);
            [self.view addSubview:rightLabel];
            rightX = CGRectGetMaxX(rightLabel.frame);
    }
    
    UILabel *YzhouTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 40, 12, lastY)];
    YzhouTitleLabel.numberOfLines = 0;
    YzhouTitleLabel.font = [UIFont systemFontOfSize:12];
    YzhouTitleLabel.text = @"缺陷次数";
    [self.view addSubview:YzhouTitleLabel];
    
    UILabel *rateTitleLabel = [[UILabel alloc] init];
    rateTitleLabel.frame = CGRectMake(rightX-10, 40, 12, lastY);
    rateTitleLabel.numberOfLines = 0;
    rateTitleLabel.font = [UIFont systemFontOfSize:12];
    rateTitleLabel.text = @"累计百分比";
    [self.view addSubview:rateTitleLabel];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.frame = CGRectMake(colonumWidth*countArray.count+originX+31, originY+10, 1, rowHeight*10);
    rightLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:rightLine];
    float minX = 0,minY = 0,maxX = 0,maxY = 0;
    for (int i=0;i<countArray.count;i++) {
        NSNumber *count = countArray[i];
        UIView *countView = [[UIView alloc] init];
        countView.backgroundColor = colorArray[i];
        countView.frame = CGRectMake(CGRectGetMaxX(leftLine.frame)+i*(colonumWidth+1), CGRectGetMaxY(leftLine.frame)-rowHeight*(count.floatValue/5), colonumWidth, rowHeight*(count.floatValue/5));
        [self.view addSubview:countView];
        UILabel *rowTitleLabel = [[UILabel alloc] init];
        rowTitleLabel.font = [UIFont systemFontOfSize:12];
        rowTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        rowTitleLabel.numberOfLines = 0;
        rowTitleLabel.text = rowTitle[i];
        CGSize size = [rowTitleLabel.text boundingRectWithSize:CGSizeMake(12, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rowTitleLabel.font} context:nil].size;
        rowTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(countView.frame)+5, 12, size.height);
        rowTitleLabel.center = CGPointMake(countView.center.x, rowTitleLabel.center.y);
        [self.view addSubview:rowTitleLabel];
        if (i==0) {
            minX = rowTitleLabel.frame.origin.x;
            minY = rowTitleLabel.frame.origin.y;
            maxX = CGRectGetMaxX(rowTitleLabel.frame);
            maxY = CGRectGetMaxY(rowTitleLabel.frame);
        } else if (i<3) {
            float y = CGRectGetMaxY(rowTitleLabel.frame);
            float x = CGRectGetMaxX(rowTitleLabel.frame);
            maxY = MAX(y, maxY);
            maxX = MAX(x, maxX);
        }
    }
    
    for (int i = minX-5; i<maxX+5; i+=6) {
        UIView *view = [[UIView alloc] init];
        view.frame  = CGRectMake(i, minY-3, 3, 1);
        [self.view addSubview:view];
        view.backgroundColor = [UIColor redColor];
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(i, maxY+5, 3, 1);
        [self.view addSubview:view2];
        view2.backgroundColor = [UIColor redColor];
    }
    
    for (int i = minY - 3; i<maxY+5; i+=6) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(minX-5, i, 1, 3);
        [self.view addSubview:view];
        view.backgroundColor = [UIColor redColor];
        UIView *view2 = [[UIView alloc] init];
        view2.frame = CGRectMake(maxX+5, i, 1, 3);
        [self.view addSubview:view2];
        view2.backgroundColor = [UIColor redColor];
    }
    
    int count = 0;
    int i=0;
    for (float x=0; x<=41*countArray.count-5; x++) {
//        double y = 0.0373*pow(x/41+1, 4)-1.0321*pow(x/41+1, 3)+11.279*pow(x/41+1, 2)-61.985*pow(x/41+1, 1)+321.90;
//        double y = -0.7278*pow(x/41+1, 3)+15.226*pow(x/41+1, 2)-113.7*(x/41+1)+369.83;
        double y = 0.0417*pow(x/41+1, 5)-0.939*pow(x/41+1, 4)+7.1553*pow(x/41+1, 3)-14.833*pow(x/41+1, 2)-63.47*(x/41+1)+342;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(x+67,y, 2, 2);
        [self.view addSubview:view];
//        BOOL first = YES;
        
        if ((int)x%40 ==0 ) {
            UIView *pointView = [[UIView alloc] init];
            pointView.backgroundColor = [UIColor redColor];
            i+=1;
            if (i==2) {
                pointView.frame = CGRectMake(x+64, y+1, 6, 6);
            } else {
                pointView.frame = CGRectMake(x+66, y-2, 6, 6);
            }
            [self.view addSubview:pointView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.frame = CGRectMake(x+46, y-12, 40, 10);
            titleLabel.text = rateTitleArray[(int)x/40];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:titleLabel];
            count++;
            if (count==4) {
                for (float z=x; z<41*countArray.count; z++) {
                    UIView *line = [[UIView alloc] init];
                    line.backgroundColor = [UIColor redColor];
                    line.frame = CGRectMake(z+70, y, 1, 1);
                    if ((int)z%2==0) {
                        [self.view addSubview:line];
                    }
                }
                for (float z=y; z<270; z++) {
                    UIView *line = [[UIView alloc] init];
                    line.backgroundColor = [UIColor redColor];
                    line.frame = CGRectMake(x+70, z, 1, 1);
                    if ((int)z%2==0) {
                        [self.view addSubview:line];
                    }
                }
            }
        }
        
    }
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"111.png"];
//    imageView.frame = CGRectMake(170, 70, 89, 100);
//    [self.view addSubview:imageView];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 410, 100, 20)];
//    [self.view addSubview:label];
//    label.font = [UIFont systemFontOfSize:10];
//    label.text = @"制表人：刘旗";
//
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(200, 410, 150, 20)];
//    [self.view addSubview:label2];
//    label2.font = [UIFont systemFontOfSize:10];
//    label2.text = @"制表日期：2017.12.10";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
