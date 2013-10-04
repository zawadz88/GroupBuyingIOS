//
//  GBOfferTableViewController.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTUITableViewZoomController.h"

@interface GBOfferTableViewController : UITableViewController

@property (strong, nonatomic) UIViewController *parentVC;

- (void)refreshContent;

@end
