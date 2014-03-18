//
//  FSAppDelegate.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 9/6/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
