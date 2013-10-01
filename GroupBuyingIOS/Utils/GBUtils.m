//
//  GBUtils.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 01.10.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBUtils.h"
@implementation GBUtils

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end