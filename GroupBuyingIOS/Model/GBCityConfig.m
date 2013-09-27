//
//  GBCityConfig.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBCityConfig.h"

@implementation GBCityConfig

#define CITY_CONFIG_FIELD_MY_CITY @"myCity"
#define CITY_CONFIG_FIELD_CITIES @"cities"

- (id)initWithDictionary:(NSDictionary *)dictionary //designated initializer
{
    self = [self init];
    if (self) {
        if (dictionary) {
            if (![[dictionary objectForKey:CITY_CONFIG_FIELD_MY_CITY] isKindOfClass:[NSNull class]]) {
                _myCity = [[GBCity alloc] initWithDictionary:[dictionary objectForKey:CITY_CONFIG_FIELD_MY_CITY]];
            }
            if (![[dictionary objectForKey:CITY_CONFIG_FIELD_CITIES] isKindOfClass:[NSNull class]]) {
                NSArray *citiesDictionaries = [dictionary objectForKey:CITY_CONFIG_FIELD_CITIES];
                NSMutableArray * citiesBuilder = [[NSMutableArray alloc] init];
                if (citiesDictionaries) {
                    for (NSDictionary * cityDictionary in citiesDictionaries) {
                        GBCity * city = [[GBCity alloc] initWithDictionary:cityDictionary];
                        [citiesBuilder addObject:city];
                    }
                }
                _cities = [NSArray arrayWithArray:citiesBuilder];
            }
        }
    }
    return self;
}
@end
