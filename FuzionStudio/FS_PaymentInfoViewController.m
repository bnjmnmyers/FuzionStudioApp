//
//  FS_PaymentInfoViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/2/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_PaymentInfoViewController.h"

@interface FS_PaymentInfoViewController ()

@end

@implementation FS_PaymentInfoViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
	[self setNeedsStatusBarAppearanceUpdate];
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
