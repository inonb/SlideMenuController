//
//  ContentViewController.m
//  SlideMenuController
//
//  Created by Inoue Takayuki on 11/12/16.
//  Copyright (c) 2011年 Inoue Takayuki. All rights reserved.
//

#import "ContentViewController.h"

@implementation ContentViewController
@synthesize navigationController;

- (void)viewDidUnload
{
    self.navigationController = nil;
    [super viewDidUnload];
}

@end
