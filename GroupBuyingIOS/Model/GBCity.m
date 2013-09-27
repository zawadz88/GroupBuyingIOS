//
//  GBCity.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBCity.h"

@implementation GBCity

#define CITY_FIELD_CITY_ID @"cityId"
#define CITY_FIELD_CITY_NAME @"name"
#define CITY_FIELD_LATITUDE @"latitude"
#define CITY_FIELD_LONGITUDE @"longitude"

- (id)initWithDictionary:(NSDictionary *)dictionary //designated initializer
{
    self = [self init];
    if(self) {
        if(dictionary) {
            if (![[dictionary objectForKey:CITY_FIELD_CITY_ID] isKindOfClass:[NSNull class]]) {
                _cityId = [dictionary objectForKey:CITY_FIELD_CITY_ID];
            }
            if (![[dictionary objectForKey:CITY_FIELD_CITY_NAME] isKindOfClass:[NSNull class]]) {
                _name = [dictionary objectForKey:CITY_FIELD_CITY_NAME];
            }
            if (![[dictionary objectForKey:CITY_FIELD_LATITUDE] isKindOfClass:[NSNull class]]) {
                _latitude = [dictionary objectForKey:CITY_FIELD_LATITUDE];
            }
            if (![[dictionary objectForKey:CITY_FIELD_LONGITUDE] isKindOfClass:[NSNull class]]) {
                _longitude = [dictionary objectForKey:CITY_FIELD_LONGITUDE];
            }            
        }
    }
    return self;
}

@end
