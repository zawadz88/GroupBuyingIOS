//
//  GBOfferTableViewCell.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBOfferTableViewCell.h"

#define CELL_WIDTH 320
#define CELL_HEIGHT 200

@implementation GBOfferTableViewCell

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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.backgroundColor = [UIColor grayColor];
    } else {
        self.backgroundColor = [UIColor greenColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, CELL_WIDTH, CELL_HEIGHT);
}

@end
