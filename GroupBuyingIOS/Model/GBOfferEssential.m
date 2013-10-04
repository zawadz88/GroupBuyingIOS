//
//  GBOfferEssential.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBOfferEssential.h"
#import "GBAppConstants.h"

@implementation GBOfferEssential

#define OFFER_ESSENTIAL_FIELD_OFFER_ID @"offerId"
#define OFFER_ESSENTIAL_FIELD_TITLE @"title"
#define OFFER_ESSENTIAL_FIELD_IMAGE_URL @"imageUrl"
#define OFFER_ESSENTIAL_FIELD_PRICE @"price"
#define OFFER_ESSENTIAL_FIELD_PRICE_BEFORE_DISCOUNT @"priceBeforeDiscount"
#define OFFER_ESSENTIAL_FIELD_START_DATE @"startDate"
#define OFFER_ESSENTIAL_FIELD_END_DATE @"endDate"
#define OFFER_ESSENTIAL_FIELD_CATEGORY @"category"
#define OFFER_ESSENTIAL_FIELD_LATITUDE @"latitude"
#define OFFER_ESSENTIAL_FIELD_LONGITUDE @"longitude"
#define OFFER_ESSENTIAL_FIELD_SOLD_COUNT @"soldCount"

- (id)initWithDictionary:(NSDictionary *)dictionary //designated initializer
{
    self = [self init];
    if(self) {
        if(dictionary) {
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_OFFER_ID] isKindOfClass:[NSNull class]]) {
                _offerId = [dictionary integerForKey:OFFER_ESSENTIAL_FIELD_OFFER_ID];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_TITLE] isKindOfClass:[NSNull class]]) {
                _title = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_TITLE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_IMAGE_URL] isKindOfClass:[NSNull class]]) {
                _imageUrl = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_IMAGE_URL];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_PRICE] isKindOfClass:[NSNull class]]) {
                _price = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_PRICE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_PRICE_BEFORE_DISCOUNT] isKindOfClass:[NSNull class]]) {
                _priceBeforeDiscount = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_PRICE_BEFORE_DISCOUNT];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_START_DATE] isKindOfClass:[NSNull class]]) {
                _startDate = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_START_DATE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_END_DATE] isKindOfClass:[NSNull class]]) {
                _endDate = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_END_DATE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_CATEGORY] isKindOfClass:[NSNull class]]) {
                _category = [GBOfferEssential categoryFromString:[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_CATEGORY]];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_LATITUDE] isKindOfClass:[NSNull class]]) {
                _latitude = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_LATITUDE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_LONGITUDE] isKindOfClass:[NSNull class]]) {
                _longitude = [dictionary objectForKey:OFFER_ESSENTIAL_FIELD_LONGITUDE];
            }
            if (![[dictionary objectForKey:OFFER_ESSENTIAL_FIELD_SOLD_COUNT] isKindOfClass:[NSNull class]]) {
                _soldCount = [dictionary integerForKey:OFFER_ESSENTIAL_FIELD_SOLD_COUNT];
            }
        }
    }
    return self;
}

+ (NSString *)categoryFromString:(NSString *) categoryString
{
    NSString *category = nil;
    static NSArray* categoryArray = nil;
    if (categoryArray) {
        categoryArray = [[NSArray alloc] initWithObjects: OFFER_CATEGORY_SHOPPING, OFFER_CATEGORY_CITY, OFFER_CATEGORY_TRAVEL, nil];
    }
    NSUInteger n = [categoryArray indexOfObject:categoryString];
    if ( n != NSNotFound ) {
        category = [categoryArray objectAtIndex:n];
    }
    return category;
}

- (CGFloat)imageHeight
{
    if (!_imageHeight) {
        _imageHeight = 200;
    }
    return _imageHeight;
}

@end
