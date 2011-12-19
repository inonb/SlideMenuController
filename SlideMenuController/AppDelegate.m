//
//  AppDelegate.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/09.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.window.rootViewController = menuViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
