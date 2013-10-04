//
//  GBViewPagerIndicator.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 04.10.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBViewPagerIndicator.h"

@implementation GBViewPagerIndicator

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"GBViewPagerIndicator" owner:self options:nil];
    [self addSubview: self.contentView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"GBViewPagerIndicator" owner:self options:nil];
        [self addSubview: self.contentView];
    }
    return self;
}

@end
