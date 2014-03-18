//
//  FS_ClassDetailsTabBarController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/2/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_ClassDetailsTabBarController.h"

@interface FS_ClassDetailsTabBarController ()

@end

@implementation FS_ClassDetailsTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.tabBar setTintColor:[UIColor colorWithRed:(112.0/255.0) green:(18.0/255.0) blue:(17.0/255.0) alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
