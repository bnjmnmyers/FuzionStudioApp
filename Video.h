//
//  Video.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 3/1/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Video : NSManagedObject

@property (nonatomic, retain) NSNumber * videoID;
@property (nonatomic, retain) NSString * videoName;
@property (nonatomic, retain) NSString * videoLink;

@end
