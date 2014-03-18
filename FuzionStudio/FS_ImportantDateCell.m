//
//  FS_ImportantDateCell.m
//  FuzionStudio
//
//  Created by Benjamin Myers on 1/10/14.
//  Copyright (c) 2014 BenjaminMyers.com. All rights reserved.
//

#import "FS_ImportantDateCell.h"

@implementation FS_ImportantDateCell

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
    return @"ImportantDateIdentifier";
}

@end
