//
//  GBApiOfferTemplate.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBApiOfferEssentialsTemplate.h"
#import "GBURLRequest.h"

@implementation GBApiOfferEssentialsTemplate

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

- (void)getOffersByCategory:(NSString *)category AndPageNumber:(NSInteger)pageNumber WithDelegate:(id<GBApiOfferEssentialsTemplateDelegate>)delegate
{
    NSURL *url = [GBConnectionSettings urlWithFormat:@"/offers/%@?page=%d", category, pageNumber];
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
                                   NSArray *offerArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!error) {
                                       DLog(@"%@", offerArray);
                                       NSMutableArray *offers = [[NSMutableArray alloc] init];
                                       if (offerArray) {
                                           for(NSDictionary * offerDictionary in offerArray) {
                                               GBOfferEssential *offer = [[GBOfferEssential alloc] initWithDictionary:offerDictionary];
                                               [offers addObject:offer];
                                           }
                                       }
                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                           [delegate getOfferEssentialsDidSucceedWithResults:[NSArray arrayWithArray:offers]];
                                       });
                                   } else {
                                       dispatch_sync(dispatch_get_main_queue(), ^{
                                           [delegate getOfferEssentialsDidFailWithError:error];
                                       });
                                   }
                                   
                               } else if (error) {
                                   [self requestDidFailWithError:error];
                                   dispatch_sync(dispatch_get_main_queue(), ^{
                                       [delegate getOfferEssentialsDidFailWithError:error];
                                   });
                               } else if (statusCode != 200) {
                                   [self requestDidNotSucceedWithDefaultMessage:@"A problem occurred while retrieving offers." response:response];
                               }
                           }];
}

@end
