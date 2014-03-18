//
//  ImportantDate.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/21/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImportantDate : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * dayOfTheWeek;
@property (nonatomic, retain) NSString * eventType;
@property (nonatomic, retain) NSNumber * dateID;

@end
