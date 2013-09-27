//
//  GBAppSettings.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBConnectionSettings.h"

#define OAUTH_CLIENT_ID                     @"a08318eb478a1ee31f69a55276f3af64"
#define OAUTH_CLIENT_SECRET                 @"80e7f8f7ba724aae9103f297e5fb9bdf"
#define GROUPBUYING_URL						@"http://192.168.0.19:8080/group-buying-rest"

@implementation GBConnectionSettings


+ (NSString *)clientId
{
    return OAUTH_CLIENT_ID;
}

+ (NSString *)clientSecret
{
    return OAUTH_CLIENT_SECRET;
}

+ (NSString *)url
{
    return GROUPBUYING_URL;
}

+ (NSURL *)urlWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    va_list arguments;
    va_start(arguments, format);
    NSString* s = [[NSString alloc] initWithFormat:format arguments:arguments];
    va_end(arguments);
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", GROUPBUYING_URL, s]];
}

@end
