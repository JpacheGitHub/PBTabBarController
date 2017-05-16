//
//  PBTabBarItem.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBTabBarItem.h"
#import "PBTabBarButton.h"

@interface PBTabBarItem ()



@end

@implementation PBTabBarItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                         type:(PBTabBarItemType)type{
    
    if (self = [super init]) {
        if (title == nil || [title isEqualToString:@""] || [title isKindOfClass:[NSNull class]]) {
            self.haveTitle = NO;
        }else {
            self.haveTitle = YES;
        }
        self.type = type;
        [self createSubViewsWithTitle:title
                                image:image
                        selectedImage:selectedImage];
    }
    return self;
}

- (void)createSubViewsWithTitle:(NSString *)title
                          image:(UIImage *)image
                  selectedImage:(UIImage *)selectedImage {
    
    
    self.tabBarButton = [PBTabBarButton buttonWithType:UIButtonTypeCustom];
    self.tabBarButton.tabBarItemType = self.type;
    self.tabBarButton.backgroundColor = [UIColor clearColor];
    [self.tabBarButton setImage:image forState:UIControlStateNormal];
    [self.tabBarButton setImage:selectedImage forState:UIControlStateSelected];
    if (self.isHaveTitle) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.userInteractionEnabled = YES;
    }
}

#pragma mark - setter

- (void)setBadgeValue:(NSString *)badgeValue {
    if (![_badgeValue isEqualToString:badgeValue]) {
        _badgeValue = badgeValue;
    }
    _tabBarButton.badgeValue = badgeValue;
}

@end
