//
//  GBCity.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBCity : NSObject

@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
