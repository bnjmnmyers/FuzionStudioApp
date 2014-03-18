//
//  FS_CurrentScheduleCell.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 12/20/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_CurrentScheduleCell : UITableViewCell

+ (NSString *)reuseIdentifier;

@property (strong, nonatomic) IBOutlet UILabel *lblClassName;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblStudio;

@end
