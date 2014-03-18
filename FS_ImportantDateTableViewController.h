//
//  FS_ImportantDateTableViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/10/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FS_ImportantDateCell.h"

@interface FS_ImportantDateTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet FS_ImportantDateCell *importantDateCell;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;

@property (strong ,nonatomic) NSString *event;

@property (strong, nonatomic) IBOutlet UITableView *importantDateTableView;

@end
