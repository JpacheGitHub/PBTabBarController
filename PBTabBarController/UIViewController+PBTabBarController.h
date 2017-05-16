//
//  UIViewController+PBTabBarController.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBTabBarItem, PBTabBarController;

@interface UIViewController (PBTabBarController)

@property (nonatomic, strong) PBTabBarController *pb_tabBarController;

@property (nonatomic, strong) PBTabBarItem *pb_tabBarItem;

@end
