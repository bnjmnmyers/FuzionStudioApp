//
//  FS_CurrentScheduleTableViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 12/18/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import "FS_CurrentScheduleTableViewController.h"
#import "DanceClass.h"

@interface FS_CurrentScheduleTableViewController ()

@end

@implementation FS_CurrentScheduleTableViewController

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
	
	[self loadClasses];
	
	NSError *error = nil;
	if (![[self loadClasses]performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
	
	[self.classesTableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	self.title = @"Current Schedule";
    [super viewWillAppear:animated];
}

- (NSFetchedResultsController *) loadClasses
{
	if (_fetchedResultsController != nil)
	{
		return _fetchedResultsController;
	}
	
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:@"DanceClass" inManagedObjectContext:[self managedObjectContext]];
	_daySort = [NSSortDescriptor sortDescriptorWithKey:@"day" ascending:YES];
	_startTimeSort = [NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES];
	_endTimeSort = [NSSortDescriptor sortDescriptorWithKey:@"endTime" ascending:YES];
    _subDivizionSort = [NSSortDescriptor sortDescriptorWithKey:@"subDivizion" ascending:YES];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_daySort, _startTimeSort, _endTimeSort, _subDivizionSort, nil];
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
	
	_fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:_fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"day" cacheName:nil];
	
	_fetchedResultsController.delegate = self;
	
	return _fetchedResultsController;
	
	[self.classesTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
	return [secInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	NSString *sectionTitle;
	if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString: @"2"]) {
		sectionTitle = @"Monday";
	}
	else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"3"]) {
		sectionTitle = @"Tuesday";
	}
    else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"4"]) {
		sectionTitle = @"Wednesday";
	}
    else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"5"]) {
		sectionTitle = @"Thursday";
	}
	return sectionTitle;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    */
     
    FS_CurrentScheduleCell *cell = (FS_CurrentScheduleCell *)[tableView dequeueReusableCellWithIdentifier:[_currentScheduleCell reuseIdentifier]];
    if (cell == nil) {
     [[NSBundle mainBundle] loadNibNamed:@"CurrentScheduleCell" owner:self options:nil];
        cell = _currentScheduleCell;
        _currentScheduleCell = nil;
     }
    
	DanceClass *danceClass = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if (![danceClass.subDivizion isEqualToString:@"Miscellaneous"]) {
		cell.lblClassName.text = [NSString stringWithFormat:@"%@: %@", danceClass.subDivizion, danceClass.name];
	}
	else{
		cell.lblClassName.text = [NSString stringWithFormat:@"%@", danceClass.name];
	}
	
    cell.lblTime.text = [NSString stringWithFormat:@"Time: %@-%@", danceClass.startTime, danceClass.endTime];
    cell.lblStudio.text = danceClass.room;
	cell.alpha = 0;
    
    // Configure the cell...
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0,200,320,244)];
	tempView.backgroundColor=[UIColor clearColor];
	
	UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,320,32)];
	//tempLabel.backgroundColor = [UIColor colorWithRed:(112/255.0) green:(18/255.0) blue:(17/255.0) alpha:1.0];
	tempLabel.backgroundColor = [UIColor blackColor];
	//tempLabel.shadowColor = [UIColor blackColor];
	//tempLabel.shadowOffset = CGSizeMake(0,2);
	tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
	//tempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSizeForHeaders];
	//tempLabel.font = [UIFont boldSystemFontOfSize:fontSizeForHeaders];
	
	NSString *sectionTitle;
	if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString: @"2"]) {
		sectionTitle = @"Monday";
	}
	else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"3"]) {
		sectionTitle = @"Tuesday";
	}
    else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"4"]) {
		sectionTitle = @"Wednesday";
	}
    else if ([[[[self.fetchedResultsController sections]objectAtIndex:section]name] isEqualToString:@"5"]) {
		sectionTitle = @"Thursday";
	}
	
	tempLabel.text = [NSString stringWithFormat:@"  %@", sectionTitle];
	
	[tempView addSubview:tempLabel];
	
	//[tempLabel release];
	return tempView;
}

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
