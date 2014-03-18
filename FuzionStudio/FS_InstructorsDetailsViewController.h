//
//  FS_InstructorsDetailsViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 11/13/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instructor.h"

@interface FS_InstructorsDetailsViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Instructor *currentInstructor;

@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSEntityDescription *entity;
@property (nonatomic, strong) NSSortDescriptor *sort;
@property (nonatomic, strong) NSPredicate *predicate;
@property (nonatomic, strong) NSArray *sortDescriptors;
@property (nonatomic, strong) NSArray *fetchedObjects;

@property (nonatomic, weak) NSString *userID;

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *streetField;
@property (strong, nonatomic) IBOutlet UITextField *cityField;
@property (strong, nonatomic) IBOutlet UITextField *stateField;
@property (strong, nonatomic) IBOutlet UITextField *zipField;

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *activeField;

- (IBAction)editInstructor:(id)sender;
- (IBAction)saveInstructor:(id)sender;
- (IBAction)endTyping:(id)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender;
- (IBAction)textFieldDidEndEditing:(UITextField *)sender;
@end
