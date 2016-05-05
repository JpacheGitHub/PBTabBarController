//
//  AppDelegate.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/25.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "AppDelegate.h"
#import "PBTabBarControllerHeader.h"


#import "PBOneViewController.h"
#import "PBTwoViewController.h"
#import "PBThreeViewController.h"
#import "PBFourViewController.h"

@interface AppDelegate ()<PBTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置类型
    // 需要特殊形状按钮时, 若下面没有手动设置关联 VC 的特殊形状 item 则自动在 tabBar 中心加入圆形按钮, 点击事件需遵循代理 PBTabBarControllerDelegate ;
    PBTabBarController *tabBar = [[PBTabBarController alloc] initWithType:PBTabBarControllerCircleType];
    tabBar.pb_delegate = self;
    tabBar.specialItemImage = [UIImage imageNamed:@"jiahao"];
    tabBar.specialItemSelectedImage = [UIImage imageNamed:@"jiahao"];
    
    
    PBOneViewController *one = [[PBOneViewController alloc] init];
    UINavigationController *oneNav = [[UINavigationController alloc] initWithRootViewController:one];
    
    // 调用 pb_tabBarItem 和 pb_tabBarController 属性时需注意层级关系, 在有 navigationController 时 在 nav 中调用;
    
    oneNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_mainframe"] selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"] type:PBTabBarItemDefaultType];
    
    
    PBTwoViewController *two = [[PBTwoViewController alloc] init];
    UINavigationController *twoNav = [[UINavigationController alloc] initWithRootViewController:two];
    twoNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_contacts"] selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"] type:PBTabBarItemDefaultType];
    
    
    PBThreeViewController *three = [[PBThreeViewController alloc] init];
    UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:three];
    threeNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"] type:PBTabBarItemDefaultType];
    
    
    PBFourViewController *four = [[PBFourViewController alloc] init];
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:four];
    fourNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage imageNamed:@"tabbar_meHL"] type:PBTabBarItemDefaultType];
    
    
    PBThreeViewController *five = [[PBThreeViewController alloc] init];
    UINavigationController *fiveNav = [[UINavigationController alloc] initWithRootViewController:five];
    fiveNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_mainframe"] selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"] type:PBTabBarItemDefaultType];
    
    
    tabBar.viewControllers = @[oneNav, twoNav, threeNav, fourNav];
    self.window.rootViewController = tabBar;
    
    
    
    [self.window makeKeyAndVisible];
    
    oneNav.pb_tabBarItem.badgeValue = @"99";
    return YES;
}

// 特殊按钮点击事件
- (void)tabBarSelectedSpecialItem:(PBTabBar *)tabBar {
    NSLog(@"这是圆形按钮点击事件");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
