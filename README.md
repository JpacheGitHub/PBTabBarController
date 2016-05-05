# PBTabBarController
自定义 tabBar。
包含三种样式：
- 常规 tabBar 样式。
- 带有圆形自定义按钮样式（类似闲鱼tabBar）。
- 带有方形自定义按钮样式（类似新浪微博 tabBar）。

## 初始化方法

```bash
- (instancetype)initWithType:(PBTabBarControllerType)type;
```

UITabBarControllerType 分为三种：

- PBTabBarControllerDefaultType（常规类型）
- PBTabBarControllerCircleType（圆形按钮）
- PBTabBarControllerSquareType（方形按钮）

## 特殊按钮设置

特殊按钮的点击事件需遵循代理

```bash
tabBar.pb_delegate = self;
// 设置特殊按钮未选中图片样式
tabBar.specialItemImage = [UIImage imageNamed:@"jiahao"];
// 设置特殊按钮选中图片样式
tabBar.specialItemSelectedImage = [UIImage imageNamed:@"jiahao"];
```

若自定义按钮需要关联 VC，可直接在 tabBatItem 初始化时进行设置

```bash

PBOneViewController *one = [[PBOneViewController alloc] init];
UINavigationController *oneNav = [[UINavigationController alloc] initWithRootViewController:one];

// 调用 pb_tabBarItem 和 pb_tabBarController 属性时需注意层级关系, 在有 navigationController 时 在 nav 中调用;

oneNav.pb_tabBarItem = [[PBTabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_mainframe"] selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"] type:PBTabBarItemCircleType];

```

注：
    若 tabBarItem 中无特殊按钮样式，则自动在居中的位置补全一个相应类型的item。
