//
//  DanceClass.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/1/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DanceClass : NSManagedObject

@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSString * divizion;
@property (nonatomic, retain) NSNumber * divizionID;
@property (nonatomic, retain) NSString * endTime;
@property (nonatomic, retain) NSNumber * instructorID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * subDivizion;
@property (nonatomic, retain) NSNumber * subDivizionID;

@end
