//
//  RootViewController.h
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/09.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideNavigationController;

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (assign) BOOL isMenu;

- (IBAction)slide:(id)sender;
- (CGFloat)slideWidth;
- (void)addViewController:(SlideNavigationController *)navigationController withTitle:(NSString*)title;
@end
