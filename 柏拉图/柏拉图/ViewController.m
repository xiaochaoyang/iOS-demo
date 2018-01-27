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
    
    NSArray *rateTitleArray = @[@"",@"33.33%",@"60%",@"80%",@"93.33%",@"100%"];
    NSArray *countArray = @[@5,@4,@3,@2,@1];
    NSArray *rowTitle = @[@"测量工具不统一    ",@"病人心情紧张      ",@"穿刺技术不熟练    ",@"穿刺位置选择不正确",@"测量方法的误差    "];
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
        leftlabel.text = [NSString stringWithFormat:@"%d",(10-i)*5];
        leftlabel.frame = CGRectMake(originX, originY+rowHeight*i, 20, scaleTitleFont);
        leftlabel.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:leftlabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        line.frame = CGRectMake(CGRectGetMaxX(leftlabel.frame)+5, CGRectGetMidY(leftlabel.frame), colonumWidth*5+4, 0.5);
        [self.view addSubview:line];
        
        lastY = CGRectGetMaxY(line.frame);
            UILabel *rightLabel = [[UILabel alloc] init];
            rightLabel.font = [UIFont systemFontOfSize:10];
            rightLabel.text = [NSString stringWithFormat:@"%.2f%%",(100.0-10*i)*2];
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
        rowTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        rowTitleLabel.numberOfLines = 0;
        rowTitleLabel.text = rowTitle[i];
        CGSize size = [rowTitleLabel.text boundingRectWithSize:CGSizeMake(12, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:rowTitleLabel.font} context:nil].size;
        rowTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(countView.frame)+5, 12, size.height);
        rowTitleLabel.center = CGPointMake(countView.center.x, rowTitleLabel.center.y);
        [self.view addSubview:rowTitleLabel];
    }
    int count = 0;
    for (float x=0; x<=41*5; x++) {
        double y = 3.3332*pow(x/41+1, 2) -43.332*(x/41+1) +310;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(x+67,y, 2, 2);
        [self.view addSubview:view];
        if ((int)x%40 ==0 ) {
            UIView *pointView = [[UIView alloc] init];
            pointView.backgroundColor = [UIColor redColor];
            pointView.frame = CGRectMake(x+66, y-4, 6, 6);
            [self.view addSubview:pointView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.frame = CGRectMake(x+46, y-12, 40, 10);
            titleLabel.text = rateTitleArray[(int)x/40];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:titleLabel];
            count++;
            if (count==4) {
                for (float z=x; z<41*5; z++) {
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
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"111.png"];
    imageView.frame = CGRectMake(140, 70, 89, 100);
    [self.view addSubview:imageView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
