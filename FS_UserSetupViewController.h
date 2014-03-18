//
//  FS_UserSetupViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/25/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_UserSetupViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)editUser;
- (IBAction)saveUser;
- (IBAction)hideKeyboard:(id)sender;
@end
