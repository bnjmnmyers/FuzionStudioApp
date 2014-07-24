//
//  FS_DressCodeTableViewController.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/2/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FS_DressCodeCell.h"
@interface FS_DressCodeTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet FS_DressCodeCell *dressCodeCell;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSSortDescriptor *divizionSort;
@property (strong, nonatomic) NSSortDescriptor *divizionIDSort;
@property (strong, nonatomic) NSSortDescriptor *subDivizionIDSort;
@property (strong, nonatomic) NSArray *sortDescriptors;

@property (strong, nonatomic) IBOutlet UITableView *dressCodeTableView;
@end
