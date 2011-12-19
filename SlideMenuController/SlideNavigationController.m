//
//  SlideNavigationController.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/16.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "SlideNavigationController.h"
#import "ContentViewController.h"

@implementation SlideNavigationController

@synthesize navigationBar;
@synthesize contentView;
@synthesize menuViewController;
@synthesize rootViewController = _rootViewController;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = [[UIScreen mainScreen] bounds];
        CGRect contentFrame = CGRectMake(0, [self navigationBarHeight], masterRect.size.width, masterRect.size.height - [self navigationBarHeight]);
        CGRect navigationFrame = CGRectMake(0, 0, masterRect.size.width, [self navigationBarHeight]);
        
        self.view = [[UIView alloc] initWithFrame:masterRect];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.contentView = [[UIView alloc] initWithFrame:contentFrame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.contentView];
        
        self.navigationBar = [[UINavigationBar alloc] initWithFrame:navigationFrame];
        self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.navigationBar.delegate = self;
        [self.view insertSubview:self.navigationBar aboveSubview:self.contentView];
        
    }
    return self;
}

- (id)initWithRootViewController:(ContentViewController *)rootViewController
{
    self = [self init];
    if(self) {
        _rootViewController = rootViewController;
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:UIBarButtonItemStyleBordered target:rootViewController action:@selector(slide:)];
        rootViewController.navigationItem.leftBarButtonItem = menuButton;
        
        [self addChildViewController:rootViewController];
        [self.contentView addSubview:rootViewController.view];
        [self.navigationBar pushNavigationItem:rootViewController.navigationItem animated:YES];
        
        rootViewController.navigationController = self;
    }
    return self;
}

- (void)viewDidUnload
{
     _rootViewController = nil;
    self.navigationBar = nil;
    self.contentView = nil;
    self.menuViewController = nil;
    [super viewDidUnload];
}

#pragma mark UINavigationBar Delegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    [self popViewController:YES];    
    return YES;
}

#pragma mark Child ViewControllers Management

- (void)pushViewController:(ContentViewController *)controller animated:(BOOL)animated
{
    [self addChildViewController:controller];
    [self.navigationBar pushNavigationItem:controller.navigationItem animated:animated];
    controller.navigationController = self;
    
    if([self.childViewControllers count] == 1) {
        
        controller.view.frame = self.contentView.bounds;
        [self.contentView addSubview:controller.view];
        
    } else {
        
        UIViewController *previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count] - 2];
        
        CGRect frame = self.contentView.bounds;
        if (animated) frame.origin.x = frame.size.width;
        controller.view.frame = frame;
        
        [self transitionFromViewController:previousController 
                          toViewController:controller 
                                  duration:0.3 
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{
                                    if (animated) {
                                        CGRect frame;
                                        frame = previousController.view.frame;
                                        frame.origin.x = -frame.size.width;
                                        previousController.view.frame = frame;
                                        
                                        frame = controller.view.frame;
                                        frame.origin.x = 0;
                                        controller.view.frame = frame;
                                    }
                                }
                                completion:nil];
    }    
}

- (void)popViewController:(BOOL)animated
{
    UIViewController *controller = [self.childViewControllers lastObject];
    UIViewController *previousController = nil;
    if([self.childViewControllers count] > 1) {
        previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count] - 2];
        CGRect frame = self.contentView.bounds;
        if (animated) frame.origin.x = -[self contentWidth];
        previousController.view.frame = frame;
    }

    if([self.childViewControllers count] > 1) {
        previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count] - 2];
    }
    
    [self transitionFromViewController: controller 
                      toViewController: previousController
                              duration: 0.3 
                               options: UIViewAnimationOptionTransitionNone 
                            animations: ^{
                                if (animated) {
                                    previousController.view.frame = self.contentView.bounds;
                                    CGRect frame = self.contentView.bounds;
                                    frame.origin.x = frame.size.width;
                                    controller.view.frame = frame;
                                }
                            } completion: ^(BOOL finished) {
                                [controller removeFromParentViewController];
                            }];
}

#pragma mark Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                  animations:^{
                      [self.navigationBar sizeToFit];
                      CGRect contentFrame = self.contentView.frame;
                      contentFrame.size.height = self.view.frame.size.height - [self navigationBarHeight];
                      contentFrame.origin.y = [self navigationBarHeight];
                      self.contentView.frame = contentFrame;
                  }];
}

- (CGFloat)navigationBarHeight
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        return 32;
    } else {
        return 44;
    }    
}

- (CGFloat)contentWidth
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        return 480;
    } else {
        return 320;
    }
}

@end
