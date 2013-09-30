//
//  GBSplashViewController.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBSplashViewController.h"
#import "GBApiCityTemplate.h"

@interface GBSplashViewController () <GBApiCityTemplateDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) GBCity *myCity;

@property (strong, nonatomic) NSArray * cities;
@end

NSTimeInterval startTime;

#define SPLASH_TIME 3 * NSEC_PER_SEC

@implementation GBSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    startTime = [[NSDate date] timeIntervalSince1970];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SPLASH_TIME), dispatch_get_current_queue(), ^{
        [self showMainController];
    });
    [[GBApiCityTemplate sharedInstance] getCityConfigWithDelegate:self];

}

- (void)showMainController
{
    if(self.myCity && self.cities) {
        DLog(@"Showing");
        [self performSegueWithIdentifier:@"Show Main" sender:nil];
    }
}

- (void)getCityConfigDidSucceedWithResults:(GBCityConfig *)cityConfig
{
    DLog(@"Yeahhhh");
    self.myCity = cityConfig.myCity;
    self.cities = cityConfig.cities;
    if ([[NSDate date] timeIntervalSince1970] - startTime > SPLASH_TIME) {
        DLog(@"Showing");
        [self performSegueWithIdentifier:@"Show Main" sender:nil];
    }
}

- (void)getCityConfigDidFailWithError:(NSError *)error
{
    DLog(@"Oh no!");
}

@end
