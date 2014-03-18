//
//  FS_CurrentScheduleCell.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 12/20/13.
//  Copyright (c) 2013 BenjaminMyers.com. All rights reserved.
//

#import "FS_CurrentScheduleCell.h"

@implementation FS_CurrentScheduleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString *)reuseIdentifier{
    return @"CurrentScheduleIdentifier";
}

@end
