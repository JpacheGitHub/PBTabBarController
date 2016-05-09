//
//  PBTabBarButton.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBTabBarButton.h"

@interface PBTabBarButton ()

@property (nonatomic, strong) UILabel *badgeValueLable;

@end

@implementation PBTabBarButton

#pragma mark - setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _badgeValueLable.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
}

- (void)setTabBarItemType:(PBTabBarItemType)tabBarItemType {
    _tabBarItemType = tabBarItemType;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (![_badgeValue isEqualToString:badgeValue]) {
        _badgeValue = badgeValue;
    }
    if (!badgeValue) {
        self.badgeValueLable.text = nil;
        self.badgeValueLable.hidden = YES;
        return;
    }
    
    self.badgeValueLable.text = badgeValue;
    self.badgeValueLable.hidden = NO;
    _badgeValueLable.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
}

#pragma mark - getter

- (UILabel *)badgeValueLable {
    if (_badgeValueLable == nil) {
        _badgeValueLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        _badgeValueLable.layer.masksToBounds = YES;
        _badgeValueLable.layer.cornerRadius = _badgeValueLable.frame.size.width / 2;
        _badgeValueLable.font = [UIFont systemFontOfSize:12];
        _badgeValueLable.textAlignment = NSTextAlignmentCenter;
        _badgeValueLable.textColor = [UIColor whiteColor];
        _badgeValueLable.backgroundColor = [UIColor redColor];
        [self addSubview:_badgeValueLable];
    }
    return _badgeValueLable;
}

@end
