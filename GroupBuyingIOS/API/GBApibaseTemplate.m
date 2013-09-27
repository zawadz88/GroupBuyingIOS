//
//  GBApiCityTemplate.m
//  GroupBuyingIOS
//
//  From GHBaseController.m
//  Greenhouse
//
//  Created by Roy Clarkson on 9/16/10.
//

#import "GBApiBaseTemplate.h"

@implementation GBApiBaseTemplate


#pragma mark -
#pragma mark Instance methods

- (void)requestDidNotSucceedWithDefaultMessage:(NSString *)message response:(NSURLResponse *)response
{
	NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
	DLog(@"HTTP Status Code: %d", statusCode);
	
    NSString *msg = message;
    id delegate = nil;
    NSString *otherButtonTitle = nil;
    switch (statusCode) {
        case 401:
            msg = @"Your access token is not valid. Please reauthorize the app.";
            delegate = [[UIApplication sharedApplication] delegate];
            break;
        default:
            break;
    }

    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:delegate
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:otherButtonTitle, nil];
        [alert show];
    });
}

- (void)requestDidFailWithError:(NSError *)error
{	
	DLog(@"%d - %@", [error code], [error localizedDescription]);
    NSString *message = nil;
    id delegate = nil;
    NSString *otherButtonTitle = nil;
    switch ([error code]) {
        case NSURLErrorUserCancelledAuthentication:
            message = @"Your access token is not valid. Please reauthorize the app.";
            delegate = [[UIApplication sharedApplication] delegate];
            break;
        case NSURLErrorTimedOut:
            message = @"The network request timed out. Please try again in a few minutes.";
            break;
        case NSURLErrorCannotConnectToHost:
            message = @"The server is unavailable. Please try again in a few minutes.";
            break;
        case kCFURLErrorNotConnectedToInternet:
            message = @"No internet connection";
            break;
        default:
            message = @"The network connection is not available. Please try again in a few minutes.";
            break;
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:otherButtonTitle, nil];
        [alert show];
    });
}

@end
