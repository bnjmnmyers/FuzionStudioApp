//
//  FS_ImportantDateTableViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/10/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_ImportantDateTableViewController.h"
#import "ImportantDate.h"

@interface FS_ImportantDateTableViewController ()

@end

@implementation FS_ImportantDateTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
	
	[self loadImportantDates];
	/*
	NSError *error = nil;
    if (![[self loadImportantDates]performFetch:&error]) {
		NSLog(@"Error! %@", error);
		abort();
	}
	*/
	[self.importantDateTableView reloadData];
    
	// Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	self.title = @"Important Dates";
    [super viewWillAppear:animated];
}

- (void)loadImportantDates
{
    _fetchRequest = [[NSFetchRequest alloc]init];
    _entity = [NSEntityDescription entityForName:@"ImportantDate" inManagedObjectContext:[self managedObjectContext]];
    _sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    _sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
    [_fetchRequest setEntity:_entity];
    [_fetchRequest setSortDescriptors:_sortDescriptors];
    
    _fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FS_ImportantDateCell *cell = (FS_ImportantDateCell *)[tableView dequeueReusableCellWithIdentifier:[_importantDateCell reuseIdentifier]];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"ImportantDateCell" owner:self options:nil];
        cell = _importantDateCell;
        _importantDateCell = nil;
	}
    
    ImportantDate *importantDate = [_fetchedObjects objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    // Configure the cell...
    cell.lblDate.text = [NSString stringWithFormat:@"%@ - %@", importantDate.dayOfTheWeek, [formatter stringFromDate:importantDate.date]];
    cell.lblEvent.text = importantDate.eventType;
    return cell;
}


/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}
 
-(NSFetchedResultsController *)loadImportantDates
{
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ImportantDate"
											  inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventType"
																   ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	_fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"eventType" cacheName:nil];
	_fetchedResultsController.delegate = self;
	
	return _fetchedResultsController;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
