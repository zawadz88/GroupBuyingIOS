//
//  GBApiOfferTemplate.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBApiBaseTemplate.h"
#import "GBOfferEssential.h"

@protocol GBApiOfferEssentialsTemplateDelegate<NSObject>

- (void)getOfferEssentialsDidSucceedWithResults:(NSArray *)newOffers;
- (void)getOfferEssentialsDidFailWithError:(NSError *)error;

@end

@interface GBApiOfferEssentialsTemplate : GBApiBaseTemplate

+ (id)sharedInstance;

- (void)getOffersByCategory:(NSString *)category AndPageNumber:(NSInteger)pageNumber WithDelegate:(id<GBApiOfferEssentialsTemplateDelegate>)delegate;

@end
