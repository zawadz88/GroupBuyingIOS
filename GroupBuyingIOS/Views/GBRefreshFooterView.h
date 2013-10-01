//
//  GBRefreshFooterView.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 01.10.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GBRefreshFooterViewDelegate<NSObject>

- (void)refreshFooterClicked;;

@end

@interface GBRefreshFooterView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (weak, nonatomic) id<GBRefreshFooterViewDelegate> delegate;

@end
