//
//  GBApiCityTemplate.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBCityConfig.h"
#import "GBApiBaseTemplate.h"

@protocol GBApiCityTemplateDelegate<NSObject>

- (void)getCityConfigDidSucceedWithResults:(GBCityConfig *)cityConfig;
- (void)getCityConfigDidFailWithError:(NSError *)error;

@end

@interface GBApiCityTemplate : GBApiBaseTemplate

+ (id)sharedInstance;

- (void) getCityConfigWithDelegate:(id<GBApiCityTemplateDelegate>)delegate;

@end