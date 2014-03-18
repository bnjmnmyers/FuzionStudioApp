//
//  FS_ImportantDateCell.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/10/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_ImportantDateCell : UITableViewCell

+ (NSString *)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblEvent;

@end
