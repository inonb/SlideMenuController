//
//  DetailViewController.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/09.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "AppDelegate.h"

@implementation DetailViewController

#pragma mark - Managing the detail item

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}



@end
