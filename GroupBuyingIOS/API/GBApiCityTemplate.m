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
    [request setTimeoutInterval:DEFAULT_REQUEST_TIMEOUT];
	DLog(@"%@", request);
    
#if OFFLINE
    DLog(@"OFFLINE REQUEST: %@", request);
    NSDictionary *offlineDictionary = [NSJSONSerialization JSONObjectWithData:[@"{\"myCity\":{\"cityId\":\"warsaw\",\"name\":\"Warszawa\",\"latitude\":50.064853,\"longitude\":19.944992},\"cities\":[{\"cityId\":\"cracow\",\"name\":\"Kraków\",\"latitude\":50.064853,\"longitude\":19.944992},{\"cityId\":\"warsaw\",\"name\":\"Warszawa\",\"latitude\":52.22985,\"longitude\":21.011438},{\"cityId\":\"wroclaw\",\"name\":\"Wrocław\",\"latitude\":51.107995,\"longitude\":17.038422}]}" dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options: NSJSONReadingMutableContainers
                                                                        error: nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            GBCityConfig *offlineCityConfig = [[GBCityConfig alloc] initWithDictionary:offlineDictionary];
            
            [delegate getCityConfigDidSucceedWithResults:offlineCityConfig];
    });
    
    return;
#endif
   
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
             [self requestDidNotSucceedWithDefaultMessage:@"A problem occurred while retrieving the configuration." response:response];
         }
     }];
}

@end
