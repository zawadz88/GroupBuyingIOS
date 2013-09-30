//
//  GBSplashViewController.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 27.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBSplashViewController.h"
#import "GBApiCityTemplate.h"

@interface GBSplashViewController () <GBApiCityTemplateDelegate>

@end

@implementation GBSplashViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];   //it hides
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [self showMainController];
    });
    [[GBApiCityTemplate sharedInstance] getCityConfigWithDelegate:self];

}

- (void)showMainController
{
    DLog(@"Showing");
    [self performSegueWithIdentifier:@"Show Main" sender:nil];
}

- (void)getCityConfigDidSucceedWithResults:(GBCityConfig *)cityConfig
{
    DLog(@"Yeahhhh");
}

- (void)getCityConfigDidFailWithError:(NSError *)error
{
    DLog(@"Oh no!");
}

@end
