//
//  FS_PolicyInfoViewController.m
//  
//
//  Created by Benjamin Myers on 1/2/14.
//
//

#import "FS_PolicyInfoViewController.h"

@interface FS_PolicyInfoViewController ()

@end

@implementation FS_PolicyInfoViewController

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
	_policyScrollView.contentSize = CGSizeMake(320, 1268);
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
