//
//  PBMoreTabBarItemView.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/29.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBMoreTabBarItemView.h"
#import "PBTabBarButton.h"

#define BUTTON_WIDTH 44
#define BUTTON_PADDING 10

@interface PBMoreTabBarItemView ()

@end

@implementation PBMoreTabBarItemView {
    NSInteger _column;
    NSInteger _line;
    NSInteger _defaultTag;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        self.layer.cornerRadius = 5;
    }
    return self;
}

#pragma mark - setter

- (void)setMoreButtons:(NSArray *)moreButtons {
    _moreButtons = moreButtons;
    [self createSubViews];
}

#pragma mark - action

- (void)moreButtonAction:(PBTabBarButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarMoreItemAction:)]) {
        [_delegate tabBarMoreItemAction:sender];
    }
}

#pragma mark - private

- (void)createSubViews {
    NSInteger moreButtonCount = _moreButtons.count - 5;
    
    _defaultTag = ((PBTabBarButton *)_moreButtons[4]).tag;
    _column = ceil(sqrt(moreButtonCount));
    _line = round(sqrt(moreButtonCount));
    
    self.frame = CGRectMake(0, 0, 40 + BUTTON_WIDTH * _column + BUTTON_PADDING * (_column - 1), 40 + BUTTON_WIDTH * _line + BUTTON_PADDING * (_line - 1));
    
    for (int li = 0; li < _line; li++) {
        for (int col = 0; col < _column; col++) {
            int index = (li + 1) * (col + 1) - 1;
            if (index >= moreButtonCount) {
                break;
            }
            
            PBTabBarButton *btn = _moreButtons[5 + index];
            btn.tag = _defaultTag + index;
            btn.frame = CGRectMake(20 + (BUTTON_WIDTH + BUTTON_PADDING) * col, 20 + (BUTTON_WIDTH + BUTTON_PADDING) * li, BUTTON_WIDTH, BUTTON_WIDTH);
            [btn addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
}

@end
