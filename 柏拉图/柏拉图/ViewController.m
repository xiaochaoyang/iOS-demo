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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *rateTitleArray = @[@"",@"33.33%",@"53.33%",@"73.33%",@"86.66%",@"100%"];
    NSArray *countArray = @[@25,@15,@15,@10,@10];
    NSArray *rowTitle = @[@"测量工具不统一",@"测量方法不准确",@"选择血管不准确",@"穿刺方法不准确",@"操作者心情紧张"];
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
        leftlabel.text = [NSString stringWithFormat:@"%d",10-i];
        leftlabel.frame = CGRectMake(originX, originY+rowHeight*i, 20, scaleTitleFont);
        leftlabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:leftlabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        line.frame = CGRectMake(CGRectGetMaxX(leftlabel.frame)+5, CGRectGetMidY(leftlabel.frame), colonumWidth*5+4, 0.5);
        [self.view addSubview:line];
        
        lastY = CGRectGetMaxY(line.frame);
        if (i%2==0) {
            UILabel *rightLabel = [[UILabel alloc] init];
            rightLabel.font = [UIFont systemFontOfSize:10];
            rightLabel.text = [NSString stringWithFormat:@"%.2f%%",100.0-10*i];
            rightLabel.textAlignment = NSTextAlignmentLeft;
            rightLabel.frame = CGRectMake(CGRectGetMaxX(line.frame)+5, originY+rowHeight*i, 60, scaleTitleFont);
            [self.view addSubview:rightLabel];
            rightX = CGRectGetMaxX(rightLabel.frame);
        }
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
    rightLine.frame = CGRectMake(colonumWidth*5+originX+31, originY+10, 1, rowHeight*10);
    rightLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:rightLine];
    for (int i=0;i<countArray.count;i++) {
        NSNumber *count = countArray[i];
        UIView *countView = [[UIView alloc] init];
        countView.backgroundColor = [UIColor colorWithRed:62.0/255 green:108.0/255 blue:176.0/255 alpha:1];
        countView.frame = CGRectMake(CGRectGetMaxX(leftLine.frame)+i*(colonumWidth+1), CGRectGetMaxY(leftLine.frame)-rowHeight*(count.floatValue/5), colonumWidth, rowHeight*(count.floatValue/5));
        [self.view addSubview:countView];
        UILabel *rowTitleLabel = [[UILabel alloc] init];
        rowTitleLabel.font = [UIFont systemFontOfSize:12];
        rowTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(countView.frame)+5, 12, 124);
        rowTitleLabel.numberOfLines = 0;
        rowTitleLabel.text = rowTitle[i];
        rowTitleLabel.center = CGPointMake(countView.center.x, rowTitleLabel.center.y);
        [self.view addSubview:rowTitleLabel];
    }
    
    for (float x=0; x<=41*5; x++) {
        double y = -0.8646*pow(x/41+1, 3) +13.601*pow(x/41+1, 2) -97.923*(x/41+1) +354.45;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(x+67,y, 2, 2);
        [self.view addSubview:view];
        if ((int)x%40 ==0 ) {
            UIView *pointView = [[UIView alloc] init];
            pointView.backgroundColor = [UIColor redColor];
            pointView.frame = CGRectMake(x+66, y-2, 6, 6);
            [self.view addSubview:pointView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.frame = CGRectMake(x+46, y-12, 40, 10);
            titleLabel.text = rateTitleArray[(int)x/40];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:titleLabel];
        }
        
    }
//    for (float x=0; x<=41*5; x++) {
//        double y = 4.7821*pow(x/41+1, 2) - 73.584*(x/41+1) +339.38;
//        if ((int)x%40 ==0 ) {
//            UILabel *titleLabel = [[UILabel alloc] init];
//            titleLabel.font = [UIFont systemFontOfSize:10];
//            titleLabel.frame = CGRectMake(x+46, y-12, 40, 10);
//            titleLabel.text = rateTitleArray[(int)x/40];
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            [self.view addSubview:titleLabel];
//        }
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
