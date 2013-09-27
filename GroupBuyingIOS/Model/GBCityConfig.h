//
//  GBCityConfig.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBCity.h"

@interface GBCityConfig : NSObject

@property (strong, nonatomic) GBCity * myCity;
@property (strong, nonatomic) NSArray *cities;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
