//
//  FS_DressCodeCell.h
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/3/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FS_DressCodeCell : UITableViewCell

+ (NSString *)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *lblSubDvizionName;
@property (strong, nonatomic) IBOutlet UILabel *lblLeotardName;
@property (strong, nonatomic) IBOutlet UILabel *lblLeotardColor;

@end
