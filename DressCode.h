//
//  DressCode.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/3/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DressCode : NSManagedObject

@property (nonatomic, retain) NSNumber * subDivizionID;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * leotardURL;
@property (nonatomic, retain) NSString * leotardName;
@property (nonatomic, retain) NSString * leotardColor;
@property (nonatomic, retain) NSString * subDivizion;
@property (nonatomic, retain) NSString * divizion;
@property (nonatomic, retain) NSNumber * divizionID;

@end
