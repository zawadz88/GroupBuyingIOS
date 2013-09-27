//
//  GBURLRequest.h
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBURLRequest : NSMutableURLRequest

- (void)setAuthorization:(NSString *)authorization;
- (void)setContentLength:(NSUInteger)contentLength;
- (void)setContentType:(NSString *)contentType;

@end
