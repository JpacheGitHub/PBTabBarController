//
//  PBTabBarController.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, PBTabBarControllerType) {
    PBTabBarControllerDefaultType,   // 常规类型
    PBTabBarControllerCircleType,    // 带有圆形按钮
    PBTabBarControllerSquareType,    // 带有方形按钮
};


@class PBTabBar, PBTabBarButton;


@protocol PBTabBarControllerDelegate <NSObject>

@optional

/**
 *  特殊功能键点击事件(特殊功能键未绑定 VC)
 */
- (void)tabBarSelectedSpecialItem:(PBTabBar *)tabBar;

@end


@interface PBTabBarController : UITabBarController

- (instancetype)initWithType:(PBTabBarControllerType)type;



@property (nonatomic, weak) id<PBTabBarControllerDelegate> pb_delegate;

@property (nonatomic, assign) PBTabBarControllerType type;

@property (nonatomic, strong, readonly) PBTabBar *pb_tabBar;

/**
 *  以下三个属性为 tabBar 需要特殊功能键, 但不需要关联 VC 时设置样式使用, 若无此需求可不进行设置
 */
/**
 *  特殊功能键常态图片
 */
@property (nonatomic, strong) UIImage *specialItemImage;
/**
 *  特殊功能键选中状态图片
 */
@property (nonatomic, strong) UIImage *specialItemSelectedImage;
/**
 *  特殊功能键 title
 */
@property (nonatomic, copy) NSString *specialItemTitle;

@end
