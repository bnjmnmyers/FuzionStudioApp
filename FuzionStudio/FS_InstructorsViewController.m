//
//  FS_InstructorsViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 9/6/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import "FS_InstructorsViewController.h"
#import "Instructor.h"
#import "FSAppDelegate.h"
#import "FS_InstructorsDetailsViewController.h"

@interface FS_InstructorsViewController ()

@end

@implementation FS_InstructorsViewController

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
	
	[self loadInstructors];
	
	NSError *error = nil;
	if (![[self loadInstructors]performFetch:&error]) {
		NSLog(@"An error has occurred: %@", error);
		abort();
	}
	
	[self.instructorsTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self loadInstructors];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"segueToDetails"]) {
		FS_InstructorsDetailsViewController *instructorDetails = (FS_InstructorsDetailsViewController *)[segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		Instructor *selectedInstructor = (Instructor *)[self.fetchedResultsController objectAtIndexPath:indexPath];
		instructorDetails.currentInstructor = selectedInstructor;
	}
}

- (NSFetchedResultsController *) loadInstructors
{
	if (_fetchedResultsController != nil)
	{
		return _fetchedResultsController;
	}
	
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:@"Instructor" inManagedObjectContext:[self managedObjectContext]];
	_sort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
	
	_fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:_fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"lastName" cacheName:nil];
	
	_fetchedResultsController.delegate = self;
	
	return _fetchedResultsController;
	
	[self.instructors reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [[self.fetchedResultsController sections]count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
	return [secInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
	return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	Instructor *instructor = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = instructor.firstName;
	if (instructor.email.length > 0) {
		cell.detailTextLabel.text = instructor.email;
	}
	
	return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
	[self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
	UITableView *tableView = self.tableView;
	
	switch (type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
		case NSFetchedResultsChangeUpdate: {
			Instructor *changedInstructor = [self.fetchedResultsController objectAtIndexPath:indexPath];
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			cell.detailTextLabel.text = changedInstructor.email;
		}
			break;
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
	switch (type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
		Instructor *inStructorToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
		[context deleteObject:inStructorToDelete];
		
		NSError *error = nil;
		if (![context save:&error]) {
			NSLog(@"Error! %@", error);
		}
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}


@end
