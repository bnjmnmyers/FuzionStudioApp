//
//  FS_CurrentScheduleTableViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 12/18/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FS_CurrentScheduleCell.h"
@interface FS_CurrentScheduleTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>;

@property (strong, nonatomic) IBOutlet FS_CurrentScheduleCell *currentScheduleCell;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *daySort;
@property (strong, nonatomic) NSSortDescriptor *startTimeSort;
@property (strong, nonatomic) NSSortDescriptor *endTimeSort;
@property (strong, nonatomic) NSSortDescriptor *subDivizionSort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSArray *fetchedObjects;

@property (strong, nonatomic) IBOutlet UITableView *classesTableView;

@end
