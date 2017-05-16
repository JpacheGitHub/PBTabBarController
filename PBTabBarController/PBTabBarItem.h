//
//  PBTabBarItem.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PBTabBarItemType) {
    PBTabBarItemDefaultType,    // 常规item
    PBTabBarItemCircleType,     // 圆形item
    PBTabBarItemSquareType,     // 方形item
    PBTabBarItemMoreType,       // 更多按钮（无需设置此类型, 当超出显示范围时自动\
                                            设置此类型）
};


@class PBTabBarButton, PBTabBar;


@interface PBTabBarItem : NSObject

/**
 *  tabBar 响应按钮
 */
@property (nonatomic, strong) PBTabBarButton *tabBarButton;
/**
 *  tabBar title显示
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 *  是否有标题
 */
@property (nonatomic, assign, getter=isHaveTitle) BOOL haveTitle;
/**
 *  Item 样式
 */
@property (nonatomic, assign) PBTabBarItemType type;
/**
 *  角标
 */
@property (nonatomic, copy) NSString *badgeValue;



- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                         type:(PBTabBarItemType)type;

@end
