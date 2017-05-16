//
//  PBTabBarButton.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTabBarItem.h"


@interface PBTabBarButton : UIButton

@property (nonatomic, assign) PBTabBarItemType tabBarItemType;

@property (nonatomic, copy) NSString *badgeValue;

@end
