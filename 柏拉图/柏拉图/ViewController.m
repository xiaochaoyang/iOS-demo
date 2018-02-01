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
    NSArray *rateTitleArray = @[@"",@"38%",@"66%",@"84%",@"90%",@"94%",@"97%",@"99%",@"100%"];
    NSArray *countArray = @[@38,@28,@18,@6,@4,@3,@2,@1];
    NSArray *rowTitle = @[@"无规范化培训",@"测量工具不统一",@"宣教不到位",@"工作量大，人力不足",@"操作考核制度不完善",@"对穿刺者不信任",@"无统一标准化流程",@"操作流程不完善"];
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
    }
    int count = 0;
    for (float x=0; x<=41*countArray.count-5; x++) {
//        double y = 0.0365*pow(x/41+1, 5)-0.8855*pow(x/41+1, 4)+7.016*pow(x/41+1, 3)-13.418*pow(x/41+1, 2) -72.856*(x/41+1) +350.17;
        double y = -0.0065*pow(x/41+1, 6)+0.231*pow(x/41+1, 5)-3.1599*pow(x/41+1, 4)+20.097*pow(x/41+1, 3)-51.652*pow(x/41+1, 2)-20.479*(x/41+1)+328.89;
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
//    imageView.frame = CGRectMake(140, 70, 89, 100);
//    [self.view addSubview:imageView];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 280, 100, 20)];
//    [self.view addSubview:label];
//    label.font = [UIFont systemFontOfSize:14];
//    label.text = @"制表人：刘旗";
//
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 280, 150, 20)];
//    [self.view addSubview:label2];
//    label2.font = [UIFont systemFontOfSize:14];
//    label2.text = @"制表日期：2017.12.20";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
