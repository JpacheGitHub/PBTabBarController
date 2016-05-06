//
//  PBTabBar.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBTabBar.h"
#import "PBTabBarButton.h"
#import "PBTabBarItem.h"
#import "PBMoreTabBarItemView.h"

#define BUTTON_DEFAULT_TAG 1024
#define CUSTOM_BUTTON_PADDING 5

@interface PBTabBar ()<PBMoreTabBarItemViewDelegate>

@property (nonatomic, strong) PBTabBarButton *selectedBtn;

@property (nonatomic, strong) PBTabBarButton *circleBtn;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@property (nonatomic, strong) NSMutableDictionary *tabBarTitles;

@property (nonatomic, strong) PBMoreTabBarItemView *moreItemView;

@property (nonatomic, assign) BOOL isHaveSpecialItem;

@property (nonatomic, assign) BOOL isTabBarCircleType;

@property (nonatomic, assign) BOOL isMoreBtnSelected;

@end

@implementation PBTabBar

#pragma mark - public

- (void)addVCItem:(PBTabBarItem *)item count:(NSInteger)count {
    
    [self.tabBarButtons addObject:item.tabBarButton];
    [item.tabBarButton addTarget:self action:@selector(tabBarVCItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (count < 5) {
        [self addSubview:item.tabBarButton];
    }
    if (item.isHaveTitle) {
        [item.tabBarButton addSubview:item.titleLabel];
        [self.tabBarTitles setObject:item.titleLabel forKey:@(count)];
    }
    
    if (item.type == PBTabBarItemCircleType) {
        _circleBtn = item.tabBarButton;
        _isTabBarCircleType = YES;
    }
    
    // 如果是第一个按钮, 则选中(按顺序一个个添加)
    if (count == 0) {
        [self tabBarVCItemAction:item.tabBarButton];
    }
}

- (void)addSpecialItem:(PBTabBarItem *)item count:(NSInteger)count {
    
    if (count > self.tabBarButtons.count) {
        [self.tabBarButtons addObject:item.tabBarButton];
    }else {
        [self.tabBarButtons insertObject:item.tabBarButton atIndex:count];
    }
    [item.tabBarButton addTarget:self action:@selector(tabBarSpecialItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (count < 5) {
        [self addSubview:item.tabBarButton];
    }
    if (item.isHaveTitle) {
        [item.tabBarButton addSubview:item.titleLabel];
        [self.tabBarTitles setObject:item.titleLabel forKey:@(count)];
    }
    
    
    if (item.type == PBTabBarItemCircleType) {
        _circleBtn = item.tabBarButton;
        _isTabBarCircleType = YES;
    }
    
    _isHaveSpecialItem = YES;
    // 如果是第一个按钮, 则选中(按顺序一个个添加)
    if (count == 0) {
        [self tabBarSpecialItemAction:item.tabBarButton];
    }
}

#pragma mark - setter

- (void)setTabBarControllerType:(PBTabBarControllerType)tabBarControllerType {
    _tabBarControllerType = tabBarControllerType;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if (selectedIndex < 0) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    PBTabBarButton *button = [self viewWithTag:BUTTON_DEFAULT_TAG + selectedIndex];
    // 1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    // 2.再将当前按钮设置为选中
    button.selected = YES;
    // 3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
}

#pragma mark - getter

- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (NSMutableDictionary *)tabBarTitles {
    if (_tabBarTitles == nil) {
        _tabBarTitles = [NSMutableDictionary dictionary];
    }
    return _tabBarTitles;
}

- (PBMoreTabBarItemView *)moreItemView {
    if (_moreItemView == nil) {
        _moreItemView = [[PBMoreTabBarItemView alloc] init];
        _moreItemView.moreTitles = self.tabBarTitles;
        _moreItemView.moreButtons = self.tabBarButtons;
        _moreItemView.delegate = self;
        _moreItemView.alpha = 0;
    }
    return _moreItemView;
}

#pragma mark - action

- (void)tabBarVCItemAction:(PBTabBarButton *)sender {
    
    if ([_moreItemView superview]) {
        [self hiddenMoreItemView];
    }
    
    // 1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    // 2.再将当前按钮设置为选中
    sender.selected = YES;
    // 3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = sender;
    
    if ([self.pb_delegate respondsToSelector:@selector(tabBarVCItem:selectedFrom:to:)]) {
        [self.pb_delegate tabBarVCItem:self selectedFrom:self.selectedBtn.tag - 1024 to:sender.tag - 1024];
    }
}

- (void)tabBarSpecialItemAction:(PBTabBarButton *)sender {
    if ([_moreItemView superview] && sender.tabBarItemType != PBTabBarItemMoreType) {
        [self hiddenMoreItemView];
    }
    
    if (sender.tabBarItemType == PBTabBarItemMoreType) {
        
        if (!_isMoreBtnSelected) {
            self.moreItemView.frame = CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame), _moreItemView.frame.size.width, _moreItemView.frame.size.height);
            [self.superview addSubview:_moreItemView];
            
            [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState) animations:^{
                
                _moreItemView.frame = CGRectMake(CGRectGetMaxX(self.frame) - _moreItemView.frame.size.width, CGRectGetMaxY(self.frame) - _moreItemView.frame.size.height - self.frame.size.height, _moreItemView.frame.size.width, _moreItemView.frame.size.height);
                _moreItemView.alpha = 1;
                _isMoreBtnSelected = YES;
            } completion:^(BOOL finished) {
                
            }];
        }else {
            [self hiddenMoreItemView];
        }
        return;
    }
    
    
//    // 1.先将之前选中的按钮设置为未选中
//    self.selectedBtn.selected = NO;
//    // 2.再将当前按钮设置为选中
//    sender.selected = YES;
//    // 3.最后把当前按钮赋值为之前选中的按钮
//    self.selectedBtn = sender;
    
    if ([self.pb_delegate respondsToSelector:@selector(tabBarSpecialItem:selectedFrom:to:)]) {
        [self.pb_delegate tabBarSpecialItem:self selectedFrom:self.selectedBtn.tag - 1024 to:sender.tag - 1024];
    }
}

#pragma mark - PBMoreTabBarItemViewDelegate

- (void)tabBarMoreItemAction:(PBTabBarButton *)sender {
    [self tabBarVCItemAction:sender];
}

#pragma mark - private

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
    NSInteger count = self.tabBarButtons.count > 5 ? 5 : self.tabBarButtons.count;
    
    for (int i = 0; i < count; i++) {
        // 取得按钮
        PBTabBarButton *btn = self.tabBarButtons[i];
        
        [self getTabBarButtonFrameWithButton:btn index:i buttonCount:count];
        
    }
    
    [self bringSubviewToFront:_circleBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.hidden == YES) {
        return nil;
    }
    
    if (_tabBarControllerType == PBTabBarControllerCircleType) {
        
        if ([self isPointInsideTabBar:point]) {
            return _circleBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)isPointInsideTabBar:(CGPoint)point {
    
    point.y = sqrt(point.y * point.y);
    
    CGFloat valueX = point.x - (self.bounds.size.width / 2);
    CGFloat valueY = point.y - (self.bounds.size.height / 2);
    
    CGFloat distance = sqrt((valueX * valueX) + (valueY * valueY));
    
    if (distance < 35) {
        return YES;
    }else {
        return NO;
    }
}

// 以下方法为设置 Button frame

- (void)getTabBarButtonFrameWithButton:(PBTabBarButton *)btn index:(int)i buttonCount:(NSInteger)count {
    
    
    if (_isHaveSpecialItem) {
        [self getSpecialTabBarButtonFrameWithButton:btn index:i buttonCount:count];
    }else {
        [self getVCTabBarButtonFrameWithButton:btn index:i buttonCount:count];
        
    }
    if (btn.tabBarItemType == PBTabBarItemSquareType || btn.tabBarItemType == PBTabBarItemMoreType || btn.tabBarItemType == PBTabBarItemCircleType) {
        return;
    }
    
    if ([self.tabBarTitles objectForKey:@(i)]) {
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(-5, btn.imageEdgeInsets.left, 5, btn.imageEdgeInsets.right);
        UILabel *label = [self.tabBarTitles objectForKey:@(i)];
        label.frame = CGRectMake(0, btn.frame.size.height - 12, btn.frame.size.width, 12);
        label.center = CGPointMake(btn.imageView.center.x, label.center.y);
    }
    
}

- (void)getSpecialTabBarButtonFrameWithButton:(PBTabBarButton *)btn index:(int)i buttonCount:(NSInteger)count {
    
    CGFloat specialWidth = 0;
    if (_isTabBarCircleType) {
        specialWidth = 70;
    }else {
        specialWidth = self.bounds.size.height - 2 * CUSTOM_BUTTON_PADDING;
    }
    CGFloat boundsWidth = self.bounds.size.width - specialWidth;
    
    btn.tag = BUTTON_DEFAULT_TAG + i;
    
    if (btn.tabBarItemType == PBTabBarItemCircleType || btn.tabBarItemType == PBTabBarItemSquareType) {
        
        [self getSpecialItemFrameWithButton:btn index:i buttonCount:count boundsWidth:boundsWidth specialWidth:specialWidth type:btn.tabBarItemType];
        btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, btn.center.y);
    }else {
        
        int front = i == 0 ? 0 : i - 1;
        
        [self getExceptSpecialItemFrameWithButton:btn index:i buttonCount:count boundsWidth:boundsWidth specialWidth:specialWidth type:btn.tabBarItemType];
        
        PBTabBarItemType tempType = ((PBTabBarButton *)self.tabBarButtons[front]).tabBarItemType;
        if ((tempType == PBTabBarItemCircleType || tempType == PBTabBarItemSquareType) && front != 0) {
            btn.tag = BUTTON_DEFAULT_TAG + front;
        }
        if (i == count - 1) {
            btn.tag = BUTTON_DEFAULT_TAG + front;
        }
    }
}

- (void)getVCTabBarButtonFrameWithButton:(PBTabBarButton *)btn index:(int)i buttonCount:(NSInteger)count {
    
    CGFloat specialWidth = 0;
    if (_isTabBarCircleType) {
        specialWidth = 70;
    }else {
        specialWidth = self.bounds.size.height - 2 * CUSTOM_BUTTON_PADDING;
    }
    CGFloat boundsWidth = self.bounds.size.width - specialWidth;
    
    btn.tag = BUTTON_DEFAULT_TAG + i;
    if (_tabBarControllerType == PBTabBarItemCircleType) {
        if (btn.tabBarItemType == PBTabBarItemCircleType || btn.tabBarItemType == PBTabBarItemSquareType) {
            
            [self getSpecialItemFrameWithButton:btn index:i buttonCount:count - 1 boundsWidth:boundsWidth specialWidth:specialWidth type:btn.tabBarItemType];
        }else {
            
            [self getExceptSpecialItemFrameWithButton:btn index:i buttonCount:count boundsWidth:boundsWidth specialWidth:specialWidth type:btn.tabBarItemType];
        }
    }else {
        btn.tag = BUTTON_DEFAULT_TAG + i;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = self.bounds.size.height - 49;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = 49;
        
        btn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)getSpecialItemFrameWithButton:(PBTabBarButton *)btn index:(int)i buttonCount:(NSInteger)count boundsWidth:(CGFloat)boundsWidth specialWidth:(CGFloat)specialWidth type:(PBTabBarItemType)type {
    
    CGFloat x = i * boundsWidth / count;
    CGFloat y = self.bounds.size.height - specialWidth;
    if (type == PBTabBarItemSquareType) {
        y = CUSTOM_BUTTON_PADDING;
    }
    CGFloat width = specialWidth;
    CGFloat height = specialWidth;
    if (type == PBTabBarItemCircleType) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = width / 2;
    }
    btn.frame = CGRectMake(x, y, width, height);
}

- (void)getExceptSpecialItemFrameWithButton:(PBTabBarButton *)btn index:(int)i buttonCount:(NSInteger)count boundsWidth:(CGFloat)boundsWidth specialWidth:(CGFloat)specialWidth type:(PBTabBarItemType)type {
    
    int front = i == 0 ? 0 : i - 1;
    int behind = i == count - 1 ? (int)count - 1 : i + 1;
    
    
    CGFloat x = i == 0 ? 0 : CGRectGetMaxX(((PBTabBarButton *)self.tabBarButtons[front]).frame);
    CGFloat y = self.bounds.size.height - 49;
    CGFloat width = boundsWidth / (count - 1);
    CGFloat height = 49;
    
    PBTabBarItemType frontType = ((PBTabBarButton *)self.tabBarButtons[front]).tabBarItemType;
    if (front != 0 && (frontType == PBTabBarItemCircleType || frontType == PBTabBarItemSquareType)) {
        width += specialWidth / 2;
        x -= specialWidth / 2;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    }
    
    PBTabBarItemType behindType = ((PBTabBarButton *)self.tabBarButtons[behind]).tabBarItemType;
    if (behind != count - 1 && (behindType == PBTabBarItemCircleType || behindType == PBTabBarItemSquareType)) {
        width += specialWidth / 2;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    }
    
    btn.frame = CGRectMake(x, y, width, height);
}

- (void)hiddenMoreItemView {
    [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
        self.moreItemView.frame = CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame), _moreItemView.frame.size.width, _moreItemView.frame.size.height);
        _moreItemView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_moreItemView removeFromSuperview];
    }];
    _isMoreBtnSelected = NO;
}

@end
