//
//  GBLoadingFooterView.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 01.10.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBLoadingFooterView.h"

@implementation GBLoadingFooterView


-(void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"GBLoadingFooterView" owner:self options:nil];
    [self addSubview: self.contentView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"GBLoadingFooterView" owner:self options:nil];
        [self addSubview: self.contentView];
    }
    return self;
}

@end
