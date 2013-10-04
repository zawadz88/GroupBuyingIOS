//
//  GBOfferTableViewCell.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <UIKit/UIKit.h>


#define OFFER_ESSENTIAL_CELL_WIDTH 320
#define OFFER_ESSENTIAL_CELL_HEIGHT 200

@interface GBOfferTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
