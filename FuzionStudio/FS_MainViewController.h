//
//  FS_MainViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 9/6/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_MainViewController : UIViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;

@property (assign, nonatomic) BOOL isConnected;
@property (strong, nonatomic) IBOutlet UIButton *btnSettings;
@property (strong, nonatomic) IBOutlet UIButton *btnPayTuition;

- (IBAction)callFuzion:(id)sender;
- (IBAction)payTuition;
- (IBAction) turnTorchOn;
@end
