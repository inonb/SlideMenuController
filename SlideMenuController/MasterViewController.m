//
//  MasterViewController.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/09.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"

@implementation MasterViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

- (void)viewDidUnload
{
    self.tableView = nil;
    [super viewDidUnload];
}

#pragma mark UITableView Delegate & Datasource
							
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = NSLocalizedString(@"Detail", @"Detail");
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)slide:(id)sender
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    MenuViewController *rootViewController = (MenuViewController *)appDelegate.window.rootViewController;
    [rootViewController slide:nil];
    self.tableView.scrollsToTop = !rootViewController.isMenu;
}

@end