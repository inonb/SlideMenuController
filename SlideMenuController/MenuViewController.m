//
//  RootViewController.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/09.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "MenuViewController.h"
#import "MasterViewController.h"
#import "Master2ViewController.h"
#import "SlideNavigationController.h"

@implementation MenuViewController

@synthesize contentView;
@synthesize searchBar;
@synthesize tableView;
@synthesize isMenu;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ContentViewController *controller = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    SlideNavigationController *navigationController = [[SlideNavigationController alloc] initWithRootViewController:controller];
    
    [self addViewController:navigationController withTitle:@"Master"];
    
    ContentViewController *controller2 = [[Master2ViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    SlideNavigationController *navigationController2 = [[SlideNavigationController alloc] initWithRootViewController:controller2];
    
    [self addViewController:navigationController2 withTitle:@"Master2"];

    self.tableView.scrollsToTop = NO;
    isMenu = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark Child ViewControllers Management

-(void)addViewController:(SlideNavigationController *)navigationController withTitle:(NSString*)title
{
    navigationController.title = title;
    navigationController.menuViewController = self;
    [self addChildViewController:navigationController];
    
    if([self.childViewControllers count] == 1)
    {
        [self.contentView addSubview:navigationController.view];
    }
}

#pragma mark UITableView Delegate & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.childViewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    SlideNavigationController *navigation = [self.childViewControllers objectAtIndex:indexPath.row];
    cell.textLabel.text = navigation.title;
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlideNavigationController *navigation = [self.childViewControllers objectAtIndex:indexPath.row];
    
    NSArray *views = [self.contentView subviews];
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:navigation.view];
    
    [self slide:nil];
    
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Slide Menu

- (IBAction)slide:(id)sender
{
    isMenu = !isMenu;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat originX = isMenu ? [self slideWidth] : 0;
        CGRect frame = contentView.frame;
        frame.origin.x = originX;
        contentView.frame = frame;         
    } completion:^(BOOL finished){
        self.tableView.scrollsToTop = isMenu;
    }];
}

- (CGFloat)slideWidth
{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        return 420;
    } else {
        return 260;
    }
}

@end
