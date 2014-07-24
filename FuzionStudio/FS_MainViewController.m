//
//  FS_MainViewController.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 9/6/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import "FS_MainViewController.h"
#import "Instructor.h"
#import "DanceClass.h"
#import "DressCode.h"
#import "ImportantDate.h"
#import "FSAppDelegate.h"
#import "Reachability.h"
#import "User.h"
#import "Video.h"
#import <AVFoundation/AVFoundation.h>


@interface FS_MainViewController ()
{
    Reachability *internetReachable;
}

@end

@implementation FS_MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
	
	_isConnected = TRUE;
	
	[self checkOnlineConnection];
    [self loadUser];
    if ([_fetchedObjects count] > 0) {
        _btnSettings.hidden = NO;
    }
	if (_isConnected == TRUE) {
		[self getInstructors];
		[self getClasses];
		[self getDates];
		[self getDressCodes];
        [self getVideos];
	}
    else{
        _btnPayTuition.hidden = YES;
    }
	// Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES animated:animated];
	[self setNeedsStatusBarAppearanceUpdate];
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInstructors{
	
	[self clearEntity:@"Instructor"];
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *instructorsDictionary = [feed objectForKey:@"instructors"];
	for (NSDictionary *diction in instructorsDictionary) {
		Instructor *newInstructor = (Instructor *)[NSEntityDescription insertNewObjectForEntityForName:@"Instructor" inManagedObjectContext:_managedObjectContext];
		newInstructor.address = NSLocalizedString([diction objectForKey:@"address"], nil);
		newInstructor.firstName = NSLocalizedString([diction objectForKey:@"firstName"], nil);
		newInstructor.lastName = NSLocalizedString([diction objectForKey:@"lastName"], nil);
		newInstructor.email = NSLocalizedString([diction objectForKey:@"email"], nil);
		newInstructor.phone = NSLocalizedString([diction objectForKey:@"phone"], nil);
		newInstructor.city = NSLocalizedString([diction objectForKey:@"city"], nil);
		newInstructor.state = NSLocalizedString([diction objectForKey:@"state"], nil);
		newInstructor.zip = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"zip"], nil) intValue]];
	}
}

- (void)getClasses{
	
	[self clearEntity:@"DanceClass"];
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?getClasses=1"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *classesDictionary = [feed objectForKey:@"classes"];
	for (NSDictionary *diction in classesDictionary) {
		DanceClass *newDanceClass = (DanceClass *)[NSEntityDescription insertNewObjectForEntityForName:@"DanceClass" inManagedObjectContext:_managedObjectContext];
		newDanceClass.day = NSLocalizedString([diction objectForKey:@"day"], nil);
		newDanceClass.divizion = NSLocalizedString([diction objectForKey:@"divizion"], nil);
		newDanceClass.divizionID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"divizionID"], nil) intValue]];
		newDanceClass.endTime = NSLocalizedString([diction objectForKey:@"endTime"], nil);
		newDanceClass.instructorID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"instructorID"], nil) intValue]];
		newDanceClass.name = NSLocalizedString([diction objectForKey:@"name"], nil);
		newDanceClass.room = NSLocalizedString([diction objectForKey:@"room"], nil);
		newDanceClass.startTime = NSLocalizedString([diction objectForKey:@"startTime"], nil);
		newDanceClass.subDivizion = NSLocalizedString([diction objectForKey:@"subDivizion"], nil);
		newDanceClass.subDivizionID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"subDivizionID"], nil) intValue]];
	}
}

- (void)getDressCodes{
	[self clearEntity:@"DressCode"];
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?getDressCode=1"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *dressCodesDictionary = [feed objectForKey:@"dressCodes"];
	for (NSDictionary *diction in dressCodesDictionary) {
		if ([diction objectForKey:@"divizionID"] ) {
			DressCode *newDressCode = (DressCode *)[NSEntityDescription insertNewObjectForEntityForName:@"DressCode" inManagedObjectContext:_managedObjectContext];
			newDressCode.leotardColor = NSLocalizedString([diction objectForKey:@"leotardColor"], nil);
			newDressCode.leotardName = NSLocalizedString([diction objectForKey:@"leotardName"], nil);
			newDressCode.leotardURL = NSLocalizedString([diction objectForKey:@"leotardURL"], nil);
			newDressCode.divizion = NSLocalizedString([diction objectForKey:@"divizion"], nil);
			newDressCode.divizionID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"divizionID"], nil) intValue]];
			newDressCode.subDivizion = NSLocalizedString([diction objectForKey:@"subDivizion"], nil);
			newDressCode.subDivizionID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"subDivizionID"], nil) intValue]];
		}
	}
	[_managedObjectContext save:nil];

}

- (void)getDates{
	[self clearEntity:@"ImportantDate"];
	
	NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?getDates=1"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *datesDictionary = [feed objectForKey:@"dates"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *dateStr;
	for (NSDictionary *diction in datesDictionary) {
		if ([diction objectForKey:@"date"]) {
			dateStr = NSLocalizedString([diction objectForKey:@"date"], nil);
            ImportantDate *newDate = [NSEntityDescription insertNewObjectForEntityForName:@"ImportantDate" inManagedObjectContext:_managedObjectContext];
            newDate.dateID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"id"], nil) intValue]];
            newDate.date = [formatter dateFromString:dateStr];
            newDate.dayOfTheWeek = NSLocalizedString([diction objectForKey:@"dayOfTheWeek"], nil);
            newDate.eventType = NSLocalizedString([diction objectForKey:@"eventType"], nil);
		}
	}
	
}

- (void)getVideos{
    [self clearEntity:@"Video"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.fuzionstudio.net/test/includes/_appJSON.php?getVideos=1"];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *videosDictionary = [feed objectForKey:@"videos"];
    NSLog(@"Videos: %@", allDataDictionary);
	for (NSDictionary *diction in videosDictionary) {
		if ([diction objectForKey:@"videoID"]) {
            Video *video = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:_managedObjectContext];
            video.videoID = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"id"], nil) intValue]];
            video.videoName = NSLocalizedString([diction objectForKey:@"videoName"], nil);
            video.videoLink = NSLocalizedString([diction objectForKey:@"performanceName"], nil);
		}
	}
}

-(void)loadUser{
    _fetchRequest = [[NSFetchRequest alloc]init];
    _entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
    [_fetchRequest setEntity:_entity];
    
    _fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:nil];
}

- (void)clearEntity:(NSString *)entity
{
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:entity inManagedObjectContext:[self managedObjectContext]];
	
	[_fetchRequest setEntity:_entity];
	
	NSError *error = nil;
	_fetchedObjects = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	for (NSManagedObject *object in _fetchedObjects) {
		[[self managedObjectContext] deleteObject:object];
	}
	
	NSError *saveError = nil;
	if (![[self managedObjectContext] save:&saveError]) {
		NSLog(@"An error has occurred: %@", saveError);
	}
}

- (IBAction)callFuzion:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:8652094372"]];
}


- (IBAction) turnTorchOn {
    // check if flashlight available
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	if ([device hasTorch] && [device hasFlash]){
		[device lockForConfiguration:nil];
		if (device.torchActive == 0) {
			[device setTorchMode:AVCaptureTorchModeOn];
			[device setFlashMode:AVCaptureFlashModeOn];
		} else {
			[device setTorchMode:AVCaptureTorchModeOff];
			[device setFlashMode:AVCaptureFlashModeOff];
		}
		[device unlockForConfiguration];
	}
}

- (IBAction)payTuition{
    [self loadUser];
    if ([_fetchedObjects count] > 0) {
        [self performSegueWithIdentifier:@"segueToPayTuition" sender:nil];
    }
    else{
        [self performSegueWithIdentifier:@"segueToUserSetup" sender:nil];
    }
}

- (void) checkOnlineConnection {

    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is not reachable
    // NOTE - change "reachableBlock" to "unreachableBlock"
    
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
		_isConnected = FALSE;
    };
	
	internetReachable.reachableBlock = ^(Reachability*reach)
    {
		_isConnected = TRUE;
    };
    
    [internetReachable startNotifier];
    
}

@end
