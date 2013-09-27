//
//  GBApiCityTemplate.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBApiCityTemplate.h"
#import "GBURLRequest.h"
@implementation GBApiCityTemplate


/**
 * Use this class method to obtain the shared instance of the class.
 */
+ (id)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void) getCityConfigWithDelegate:(id<GBApiCityTemplateDelegate>)delegate
{
    NSURL *url = [GBConnectionSettings urlWithFormat:@"/cities/city-config"];
    NSMutableURLRequest *request = [[GBURLRequest alloc] initWithURL:url];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	DLog(@"%@", request);
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         if (statusCode == 200 && data.length > 0 && error == nil) {
             DLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             NSError *error;
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             if (!error) {
                 DLog(@"%@", dictionary);
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     GBCityConfig *cityConfig = [[GBCityConfig alloc] initWithDictionary:dictionary];
                     [delegate getCityConfigDidSucceedWithResults:cityConfig];
                 });
             } else {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     [delegate getCityConfigDidFailWithError:error];
                 });
             }
             
         } else if (error) {
             [self requestDidFailWithError:error];
             dispatch_sync(dispatch_get_main_queue(), ^{
                 [delegate getCityConfigDidFailWithError:error];
             });
         } else if (statusCode != 200) {
             [self requestDidNotSucceedWithDefaultMessage:@"A problem occurred while retrieving the profile data." response:response];
         }
     }];
}

@end
