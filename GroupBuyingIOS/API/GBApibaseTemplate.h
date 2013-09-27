//
//  GBApiCityTemplate.h
//  GroupBuyingIOS
//
//  From GHBaseController.h
//  Greenhouse
//
//  Created by Roy Clarkson on 9/16/10.
//

#import <Foundation/Foundation.h>

@interface GBApiBaseTemplate : NSObject

void ProcessError(NSString* action, NSError* error);
- (void)requestDidNotSucceedWithDefaultMessage:(NSString *)message response:(NSURLResponse *)response;
- (void)requestDidFailWithError:(NSError *)error;

@end
