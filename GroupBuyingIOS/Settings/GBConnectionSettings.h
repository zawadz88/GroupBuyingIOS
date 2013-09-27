//
//  GBAppSettings.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBConnectionSettings : NSObject

+ (NSString *)clientId;
+ (NSString *)clientSecret;
+ (NSString *)url;
+ (NSURL *)urlWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

@end
