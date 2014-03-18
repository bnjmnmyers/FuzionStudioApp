//
//  User.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/25/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSNumber * zip;

@end
