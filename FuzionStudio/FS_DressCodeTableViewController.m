//
//  FS_DressCodeTableViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/2/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_DressCodeTableViewController.h"
#import "DressCode.h"
#import "FS_LeotardWebViewController.h"

@interface FS_DressCodeTableViewController ()

@end

@implementation FS_DressCodeTableViewController

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
	
	[self loadDressCodes];
	
	NSError *error = nil;
	if (![[self loadDressCodes]performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
	
	[self.dressCodeTableView reloadData];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	self.title = @"Dress Code";
    [super viewWillAppear:animated];
}

- (NSFetchedResultsController *) loadDressCodes
{
	if (_fetchedResultsController != nil)
	{
		return _fetchedResultsController;
	}
	
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:@"DressCode" inManagedObjectContext:[self managedObjectContext]];
	_divizionIDSort = [NSSortDescriptor sortDescriptorWithKey:@"divizionID" ascending:YES];
	_divizionSort = [NSSortDescriptor sortDescriptorWithKey:@"divizion" ascending:YES];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_divizionIDSort, _divizionSort, nil];
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
	
	_fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:_fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"divizion" cacheName:nil];
	
	_fetchedResultsController.delegate = self;
	
	return _fetchedResultsController;
	
	[self.dressCodeTableView reloadData];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
	 static NSString *CellIdentifier = @"Cell";
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	 */
	
    FS_DressCodeCell *cell = (FS_DressCodeCell *)[tableView dequeueReusableCellWithIdentifier:[_dressCodeCell reuseIdentifier]];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"DressCodeCell" owner:self options:nil];
        cell = _dressCodeCell;
        _dressCodeCell = nil;
	}
    
	DressCode *dressCode = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.lblSubDvizionName.text = dressCode.subDivizion;
	cell.lblLeotardName.text = [NSString stringWithFormat:@"Leotard: %@",dressCode.leotardName];
	cell.lblLeotardColor.text = [NSString stringWithFormat:@"Leotard Color: %@", dressCode.leotardColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
	sectionTitle = [[[self.fetchedResultsController sections]objectAtIndex:section]name];
	
	tempLabel.text = [NSString stringWithFormat:@"  %@", sectionTitle];
	
	[tempView addSubview:tempLabel];
	
	//[tempLabel release];
	return tempView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self performSegueWithIdentifier:@"segueToLeotardWebView" sender:nil];
    
    DressCode *chosenDressCode = (DressCode *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:chosenDressCode.leotardURL]];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//	if ([[segue identifier]isEqualToString:@"segueToLeotardWebView"]) {
//		FS_LeotardWebViewController *leotardWebViewController = [segue destinationViewController];
//		NSIndexPath *selectedIndexPath = [_dressCodeTableView indexPathForSelectedRow];
//		DressCode *chosenDressCode = (DressCode *)[self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
//		
//		leotardWebViewController.currentDressCode = chosenDressCode;
//		leotardWebViewController.requestedURL = chosenDressCode.leotardURL;
//	}
//}


@end
