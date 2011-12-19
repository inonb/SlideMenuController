//
//  SlideNavigationController.h
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/16.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;
@class ContentViewController;

@interface SlideNavigationController : UIViewController

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong, readonly) UIViewController *rootViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void)pushViewController:(ContentViewController *)controller animated:(BOOL)animated;
- (void)popViewController:(BOOL)animated;
- (CGFloat)navigationBarHeight;
- (CGFloat)contentWidth;
@end
