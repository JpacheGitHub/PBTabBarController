//
//  PBTabBarController.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBTabBarController.h"
#import "PBTabBar.h"
#import "PBTabBarItem.h"
#import "UIViewController+PBTabBarController.h"

@interface PBTabBarController ()<PBTabBarDelegate>

@property (nonatomic, assign) BOOL isHaveSpecialItem;

@end

@implementation PBTabBarController
@synthesize pb_tabBar = _pb_tabBar;

#pragma mark - init

- (instancetype)initWithType:(PBTabBarControllerType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:self.pb_tabBar forKeyPath:@"tabBar"];
}

#pragma mark - setter

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[UIViewController class]]) {
            vc.pb_tabBarController = self;
            if (vc.pb_tabBarItem.type == PBTabBarItemCircleType || vc.pb_tabBarItem.type == PBTabBarItemSquareType) {
                self.isHaveSpecialItem = YES;
            }
        }else {
            ((UINavigationController *)vc).pb_tabBarController = self;
            self.isHaveSpecialItem = YES;
        }
        [vcArr addObject:vc];
    }
    
    [super setViewControllers:vcArr];
    
    [self addTabBarItem];
}

- (void)setType:(PBTabBarControllerType)type {
    _type = type;
    self.pb_tabBar.tabBarControllerType = _type;
    
    _pb_tabBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    self.pb_tabBar.selectedIndex = selectedIndex;
}

#pragma mark - getter

- (PBTabBar *)pb_tabBar {
    if (_pb_tabBar == nil) {
        //测试添加自己的视图
        _pb_tabBar = [[PBTabBar alloc] init];
        _pb_tabBar.pb_delegate = self; //设置代理
        
        _pb_tabBar.translucent = YES;
    }
    return _pb_tabBar;
}

#pragma mark - PBTabBarDelegate

- (void)tabBarVCItem:(PBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

- (void)tabBarSpecialItem:(PBTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to sender:(PBTabBarButton *)sender{
    if (_pb_delegate && [_pb_delegate respondsToSelector:@selector(tabBarSelectedSpecialItem:sender:)]) {
        [_pb_delegate tabBarSelectedSpecialItem:tabBar sender:sender];
    }
}

#pragma mark - private

- (void)addTabBarItem {
    
    NSInteger itemCount = self.viewControllers.count;
    if ((_type == PBTabBarControllerCircleType || _type == PBTabBarControllerSquareType) && !_isHaveSpecialItem) {
        itemCount += 1;
    }
    
    BOOL isVCCountToMore = itemCount > 5 ? YES : NO;
    if (isVCCountToMore) {
        itemCount += 1;
    }
    NSInteger count = self.viewControllers.count > 4 ? 2 :self.viewControllers.count / 2;
    NSInteger arrayIndex = 0;
    
    for (int i = 0; i < itemCount; i++) {
        
        if ((_type == PBTabBarControllerCircleType || _type == PBTabBarControllerSquareType) && !_isHaveSpecialItem) {
            
            if (i == count) {
                continue;
            }
        }
        
        if (isVCCountToMore && i == 4){
            PBTabBarItem *item = [[PBTabBarItem alloc] initWithTitle:_specialItemTitle image:[UIImage imageNamed:@"Session_Multi_More_HL"] selectedImage:[UIImage imageNamed:@"Session_Multi_More_HL"] type:PBTabBarItemMoreType];
            [_pb_tabBar addSpecialItem:item count:i];
            continue;
        }else {
            UIViewController *vc = self.viewControllers[arrayIndex];
            
            [_pb_tabBar addVCItem:vc.pb_tabBarItem count:i];
        }
        
        arrayIndex += 1;
    }
    
    if ((_type == PBTabBarControllerCircleType || _type == PBTabBarControllerSquareType) && !_isHaveSpecialItem) {
        PBTabBarItem *item;
        switch (_type) {
            case PBTabBarControllerCircleType: {
                item = [[PBTabBarItem alloc] initWithTitle:_specialItemTitle image:_specialItemImage selectedImage:_specialItemSelectedImage ? _specialItemSelectedImage : _specialItemImage type:PBTabBarItemCircleType];
            }
                break;
            case PBTabBarControllerSquareType: {
                item = [[PBTabBarItem alloc] initWithTitle:_specialItemTitle image:_specialItemImage selectedImage:_specialItemSelectedImage ? _specialItemSelectedImage : _specialItemImage type:PBTabBarItemSquareType];
            }
                break;
            default:
                break;
        }
        
        [_pb_tabBar addSpecialItem:item count:count];
    }
}

@end
