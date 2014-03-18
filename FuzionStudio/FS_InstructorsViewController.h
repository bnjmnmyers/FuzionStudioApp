//
//  FS_InstructorsViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 9/6/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_InstructorsViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *instructors;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) IBOutlet UITableView *instructorsTable;

//- (void)getInstructors;
@end
