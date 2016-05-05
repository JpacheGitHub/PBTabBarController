//
//  PBMoreTabBarItemView.h
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/29.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBTabBarButton;

@protocol PBMoreTabBarItemViewDelegate <NSObject>

- (void)tabBarMoreItemAction:(PBTabBarButton *)sender;

@end

@interface PBMoreTabBarItemView : UIView

@property (nonatomic, weak) id<PBMoreTabBarItemViewDelegate> delegate;

@property (nonatomic, strong) NSArray *moreButtons;

@property (nonatomic, strong) NSDictionary *moreTitles;

@end
