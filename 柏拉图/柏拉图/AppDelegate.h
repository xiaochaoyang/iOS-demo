//
//  AppDelegate.h
//  柏拉图
//
//  Created by 肖朝阳 on 2017/11/26.
//  Copyright © 2017年 肖朝阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

