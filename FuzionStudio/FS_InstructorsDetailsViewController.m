//
//  FS_InstructorsDetailsViewController.m
//  ;
//
//  Created by Benjamin Myers on 11/13/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import "FS_InstructorsDetailsViewController.h"
#import "FSAppDelegate.h"

@interface FS_InstructorsDetailsViewController ()

@end

@implementation FS_InstructorsDetailsViewController

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
	
	_userID = _currentInstructor.email;
	_firstNameField.text = _currentInstructor.firstName;
	_lastNameField.text = _currentInstructor.lastName;
	_emailField.text = _currentInstructor.email;
	_phoneField.text = _currentInstructor.phone;
	_streetField.text = _currentInstructor.address;
	_cityField.text = _currentInstructor.city;
	_stateField.text = _currentInstructor.state;
	_zipField.text = [NSString stringWithFormat:@"%@", _currentInstructor.zip];
	
	[self registerForKeyboardNotifications];
	CGPoint contentOffset = CGPointMake(0, 60);
	_scrollView.contentOffset = contentOffset;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editInstructor:(id)sender {
	_firstNameField.enabled = YES;
	_lastNameField.enabled = YES;
	_emailField.enabled = YES;
	_phoneField.enabled = YES;
	_streetField.enabled = YES;
	_cityField.enabled = YES;
	_stateField.enabled = YES;
	_zipField.enabled = YES;
	
	_editButton.hidden = YES;
	_saveButton.hidden = NO;
	
	_firstNameField.borderStyle = UITextBorderStyleRoundedRect;
	_lastNameField.borderStyle = UITextBorderStyleRoundedRect;
	_emailField.borderStyle = UITextBorderStyleRoundedRect;
	_phoneField.borderStyle = UITextBorderStyleRoundedRect;
	_streetField.borderStyle = UITextBorderStyleRoundedRect;
	_cityField.borderStyle = UITextBorderStyleRoundedRect;
	_stateField.borderStyle = UITextBorderStyleRoundedRect;
	_zipField.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)saveInstructor:(id)sender {
	_firstNameField.enabled = NO;
	_lastNameField.enabled = NO;
	_emailField.enabled = NO;
	_phoneField.enabled = NO;
	_streetField.enabled = NO;
	_cityField.enabled = NO;
	_stateField.enabled = NO;
	_zipField.enabled = NO;
	
	_editButton.hidden = NO;
	_saveButton.hidden = YES;
	
	_firstNameField.borderStyle = UITextBorderStyleNone;
	_lastNameField.borderStyle = UITextBorderStyleNone;
	_emailField.borderStyle = UITextBorderStyleNone;
	_phoneField.borderStyle = UITextBorderStyleNone;
	_streetField.borderStyle = UITextBorderStyleNone;
	_cityField.borderStyle = UITextBorderStyleNone;
	_stateField.borderStyle = UITextBorderStyleNone;
	_zipField.borderStyle = UITextBorderStyleNone;
	
	_currentInstructor.firstName = _firstNameField.text;
	_currentInstructor.lastName = _lastNameField.text;
	_currentInstructor.email = _emailField.text;
	_currentInstructor.phone = _phoneField.text;
	_currentInstructor.address = _streetField.text;
	_currentInstructor.city = _cityField.text;
	_currentInstructor.state = _stateField.text;
	_currentInstructor.zip = [NSNumber numberWithInt:[_zipField.text intValue]];
	
	NSError *error = nil;
	NSManagedObjectContext *context = self.managedObjectContext;
	if (![context save:&error]) {
		NSLog(@"Error! %@", error);
	}
	
	[self updateDataOnServer];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateDataOnServer
{
	NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?firstName=%@&lastName=%@&email=%@&phone=%@&address=%@&city=%@&state=%@&zip=%@&userID=%@", _firstNameField.text, _lastNameField.text, _emailField.text, _phoneField.text, _streetField.text, _cityField.text, _stateField.text, _zipField.text, _userID];
	NSURL *url = [[NSURL alloc]initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	FSAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
	[delegate saveContext];
	//[self getInstructors];
}

- (void)registerForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification
{
	NSDictionary *info = [aNotification userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
	CGRect aRect = self.view.frame;
	
	_scrollView.contentInset = contentInsets;
	_scrollView.scrollIndicatorInsets = contentInsets;
	aRect.size.height -= kbSize.height;
	
	
	if (!CGRectContainsPoint(aRect, _activeField.frame.origin)) {
		[self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height - kbSize.height))];
	}
	
}

- (void)endTyping:(id)sender
{
	[sender resignFirstResponder];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	_scrollView.contentInset = contentInsets;
	_scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender {
	_activeField = nil;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
	
	_activeField = sender;

}
@end
