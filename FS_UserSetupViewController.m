//
//  FS_UserSetupViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/25/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_UserSetupViewController.h"
#import "User.h"

@interface FS_UserSetupViewController ()

@end

@implementation FS_UserSetupViewController

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
    
    id delegate = [[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    [self loadUser];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)loadUser{
    _fetchRequest = [[NSFetchRequest alloc]init];
    _entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
    [_fetchRequest setEntity:_entity];
    
    _fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:nil];
    
    if ([_fetchedObjects count] > 0) {
        User *user = [_fetchedObjects objectAtIndex:0];
        _txtName.text = user.name;
        _txtEmail.text = user.email;
        _txtName.borderStyle = UITextBorderStyleNone;
        _txtEmail.borderStyle = UITextBorderStyleNone;
    }
    else{
        _btnEdit.hidden = YES;
        _btnSave.hidden = NO;
        _txtName.enabled = YES;
        _txtEmail.enabled = YES;
        _txtName.textColor = [UIColor blackColor];
        _txtEmail.textColor = [UIColor blackColor];
        _txtName.backgroundColor = [UIColor whiteColor];
        _txtEmail.backgroundColor = [UIColor whiteColor];
        _txtName.borderStyle = UITextBorderStyleRoundedRect;
        _txtEmail.borderStyle = UITextBorderStyleRoundedRect;
    }
}

- (IBAction)editUser {
    _btnEdit.hidden = YES;
    _btnSave.hidden = NO;
    _txtName.enabled = YES;
    _txtEmail.enabled = YES;
    _txtName.textColor = [UIColor blackColor];
    _txtEmail.textColor = [UIColor blackColor];
    _txtName.backgroundColor = [UIColor whiteColor];
    _txtEmail.backgroundColor = [UIColor whiteColor];
    _txtName.borderStyle = UITextBorderStyleRoundedRect;
    _txtEmail.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)saveUser {
    if ([_fetchedObjects count] < 1 && _txtEmail.text.length > 0 && _txtName.text.length > 0) {
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
        user.name = _txtName.text;
        user.email = _txtEmail.text;
        [self.managedObjectContext save:nil];
        [self performSegueWithIdentifier:@"segueFromUserSetupToPayTuition" sender:nil];
    }
    else if(_txtEmail.text.length > 0 && _txtName.text.length > 0){
        User *user = [_fetchedObjects objectAtIndex:0];
        user.name = _txtName.text;
        user.email = _txtEmail.text;
    }
    
    _btnEdit.hidden = NO;
    _btnSave.hidden = YES;
    _txtName.enabled = NO;
    _txtEmail.enabled = NO;
    _txtName.textColor = [UIColor whiteColor];
    _txtEmail.textColor = [UIColor whiteColor];
    _txtName.backgroundColor = [UIColor clearColor];
    _txtEmail.backgroundColor = [UIColor clearColor];
    _txtName.borderStyle = UITextBorderStyleNone;
    _txtEmail.borderStyle = UITextBorderStyleNone;
}

- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];
}
@end
