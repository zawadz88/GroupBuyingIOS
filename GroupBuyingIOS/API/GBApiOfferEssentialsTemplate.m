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
	[request setTimeoutInterval:DEFAULT_REQUEST_TIMEOUT];
	DLog(@"%@", request);

#if OFFLINE
    DLog(@"OFFLINE REQUEST: %@", request);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        GBOfferEssential *offer1 = [[GBOfferEssential alloc] init];
        offer1.offerId = 1;
        offer1.title = @"Offer1";
        offer1.imageUrl = @"http://niuniacat.blox.pl/resource/00033434.jpg";
        GBOfferEssential *offer2 = [[GBOfferEssential alloc] init];
        offer2.offerId = 2;
        offer2.title = @"Offer2";
        offer2.imageUrl = @"http://shadow.pl/tellamarna/galeria/zdjecie_08.jpg";
        GBOfferEssential *offer3 = [[GBOfferEssential alloc] init];
        offer3.offerId = 3;
        offer3.title = @"Offer3";
        offer3.imageUrl = @"http://www.ekoenergia.pl/uploaded/Image/zdjecia_wesele/wielkie_zarcie_2.jpg";
        NSArray *offlineOffers = @[offer1, offer2, offer3];
        [delegate getOfferEssentialsDidSucceedWithResults:offlineOffers];
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
