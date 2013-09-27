//
//  GBURLRequest.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBURLRequest.h"

#define ACCEPT                      @"Accept"
#define AUTHORIZATION               @"Authorization"
#define CONTENT_LENGTH              @"Content-Length"
#define CONTENT_TYPE                @"Content-Type"
#define APPLICATION_FORM_URLENCODED @"application/x-www-form-urlencoded"

@implementation GBURLRequest

- (void)setAccept:(NSString *)accept
{
    [self setValue:accept forHTTPHeaderField:ACCEPT];
}

- (void)setAuthorization:(NSString *)authorization
{
    [self setValue:authorization forHTTPHeaderField:AUTHORIZATION];
}

- (void)setContentLength:(NSUInteger)contentLength
{
    [self setValue:[NSString stringWithFormat:@"%ui", contentLength] forHTTPHeaderField:CONTENT_LENGTH];
}

- (void)setContentType:(NSString *)contentType
{
    [self setValue:contentType forHTTPHeaderField:CONTENT_TYPE];
}


@end
