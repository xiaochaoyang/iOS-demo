//
//  ViewController.m
//  CALayerStudy
//
//  Created by 肖朝阳 on 2017/9/9.
//  Copyright © 2017年 肖朝阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)UIView *bgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView = [[UIView alloc] init];
    self.bgView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:self.bgView];
    
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
    
    CAShapeLayer *bottomLayer = [CAShapeLayer layer];
    bottomLayer.frame = CGRectMake(0, 0, 200, 200);
    bottomLayer.fillColor = [UIColor blueColor].CGColor;
    bottomLayer.strokeColor = [UIColor redColor].CGColor;
    bottomLayer.lineCap = kCALineCapRound;
    bottomLayer.lineWidth = 5;
    bottomLayer.path = [bottomPath CGPath];
    
    [self.bgView.layer addSublayer:bottomLayer];
    self.bgView.layer.masksToBounds = YES;
    
//    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:80 startAngle:0 endAngle:M_PI clockwise:YES];
//    CAShapeLayer *progressLayer = [CAShapeLayer layer];
//    progressLayer.frame = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
