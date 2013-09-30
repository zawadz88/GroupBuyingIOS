//
//  GBOfferEssential.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBOfferEssential : NSObject

@property (nonatomic) NSInteger offerId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *priceBeforeDiscount;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (nonatomic) NSInteger soldCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
