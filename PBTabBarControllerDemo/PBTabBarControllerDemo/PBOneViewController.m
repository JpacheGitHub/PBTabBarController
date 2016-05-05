//
//  PBOneViewController.m
//  PBTabBarControllerDemo
//
//  Created by Jpache on 16/4/27.
//  Copyright © 2016年 Jpache. All rights reserved.
//

#import "PBOneViewController.h"
#import "PBTabBarControllerHeader.h"

@interface PBOneViewController ()

@end

@implementation PBOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, self.view.frame.size.height - 80, 80, 80);
    button.backgroundColor = [UIColor blackColor];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    self.navigationController.pb_tabBarItem.badgeValue = @"99";
//    NSLog(@"%@", NSStringFromCGRect(self.navigationController.pb_tabBarItem.tabBarButton.frame));
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"touchUpInset");
    NSLog(@"%@", [self.navigationController.pb_tabBarController class]);
    NSLog(@"%@", [self.navigationController.pb_tabBarItem class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
