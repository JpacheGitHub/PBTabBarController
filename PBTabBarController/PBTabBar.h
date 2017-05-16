//
//  PBTabBar.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTabBarController.h"

extern CGFloat const PBTabBarDefaultHeight;
extern CGFloat const PBTabBarCircleHeight;
extern NSInteger const PBTabBarButtonDefaultTag;

@class PBTabBarItem;
@protocol PBTabBarDelegate;

@interface PBTabBar : UITabBar

@property (nonatomic, weak) id<PBTabBarDelegate> pb_delegate;

@property (nonatomic, assign) PBTabBarControllerType tabBarControllerType;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign, getter=iscircleToVC) BOOL circleToVC;




/**
 *  为 TabBar 添加按钮
 */
- (void)addVCItem:(PBTabBarItem *)item count:(NSInteger)count;
/**
 *  为 tabBar 添加特殊功能按钮
 */
- (void)addSpecialItem:(PBTabBarItem *)item count:(NSInteger)count;

@end


@protocol PBTabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (已经关联 VC 的 item)
 *
 *  @param tabBar 当前选中的 TabBar
 *  @param from   上一个选中的按钮位置
 *  @param to     当前选中的按钮位置
 */
- (void)tabBarVCItem:(PBTabBar *)tabBar
        selectedFrom:(NSInteger)from
                  to:(NSInteger)to;

@optional
/**
 *  工具栏为关联 VC 的特殊功能按钮被选中, 记录从哪里跳转到哪里.
 *
 *  @param tabBar 当前选中的 TabBar
 *  @param from   上一个选中的按钮位置
 *  @param to     当前选中的按钮位置
 */
- (void)tabBarSpecialItem:(PBTabBar *)tabBar
             selectedFrom:(NSInteger)from
                       to:(NSInteger)to
                   sender:(PBTabBarButton *)sender;

@end
