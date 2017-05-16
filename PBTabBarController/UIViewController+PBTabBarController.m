//
//  UIViewController+PBTabBarController.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "UIViewController+PBTabBarController.h"
#import <objc/runtime.h>

@implementation UIViewController (PBTabBarController)

#pragma mark - tabBarController

static const char PBTabBarControllerKey = '\0';
- (void)setPb_tabBarController:(PBTabBarController *)pb_tabBarController {
    if (pb_tabBarController != self.pb_tabBarController) {        
        // 存储新的
        [self willChangeValueForKey:@"pb_tabBarController"]; // KVO
        objc_setAssociatedObject(self, &PBTabBarControllerKey,
                                 pb_tabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"pb_tabBarController"]; // KVO
    }
}

- (PBTabBarController *)pb_tabBarController {
    PBTabBarController *tabBarController = objc_getAssociatedObject(self, &PBTabBarControllerKey);
    return tabBarController;
}

#pragma mark - tabBarItem

static const char PBTabBarItemKey = '\0';
- (void)setPb_tabBarItem:(PBTabBarItem *)pb_tabBarItem {
    
    if (pb_tabBarItem != self.pb_tabBarItem) {
        // 存储新的
        [self willChangeValueForKey:@"pb_tabBarItem"]; // KVO
        objc_setAssociatedObject(self, &PBTabBarItemKey,
                                 pb_tabBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"pb_tabBarItem"]; // KVO
    }
}

- (PBTabBarItem *)pb_tabBarItem {
    PBTabBarItem *tabBarItem = objc_getAssociatedObject(self, &PBTabBarItemKey);
    return tabBarItem;
}

@end
