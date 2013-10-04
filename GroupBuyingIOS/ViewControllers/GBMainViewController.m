//
//  MainViewController.m
//  ICViewPager
//
//  Created by Piotr Zawadzki on 03.10.2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//
// Worth reading: http://www.slideshare.net/bobmccune/creating-container-view-controllers
//

#import "GBMainViewController.h"
#import "GBOfferViewPagerController.h"
#import "GBViewPagerIndicator.h"
#import "GBOfferViewController.h"
#import "GBOfferEssential.h"
@interface GBMainViewController ()<ViewPagerIndicatorDelegate>

@property(strong, nonatomic) GBOfferViewPagerController *viewPager;
@property(strong, nonatomic) GBViewPagerIndicator * navigationTitleView;


@end

@implementation GBMainViewController

- (IBAction)settingsClicked:(UIBarButtonItem *)sender {
    DLog(@"Settings clicked...");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    
    self.title = @"View Pager";
    NSLog(@"Child: %@", [self.childViewControllers lastObject]);
    id child = [self.childViewControllers lastObject];
    if ([child isKindOfClass:[GBOfferViewPagerController class]]) {
        _viewPager = child;
        [self.viewPager.indicators addObject:self];
        self.viewPager.pages = [@[@"A", @"B", @"C", @"D", @"E", @"F"] mutableCopy];
        [self.viewPager reloadData];
    }
    
    CGRect navigationTitleRect = CGRectMake(0, 0, 200, 45);
    self.navigationTitleView = [[GBViewPagerIndicator alloc] initWithFrame:navigationTitleRect];
    self.navigationItem.titleView = self.navigationTitleView;
    self.navigationTitleView.label.text = [NSString stringWithFormat:@"Title: %@", @"A"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewPager:(ViewPagerController *)viewPager contentMovedByRatio:(CGFloat)movedRatio
{
    if ((viewPager.activeTabIndex > 0 && viewPager.activeTabIndex < viewPager.tabCount - 1) || (viewPager.activeTabIndex == 0 && movedRatio > 0) || (viewPager.activeTabIndex == viewPager.tabCount - 1 && movedRatio < 0)) {
        self.navigationTitleView.label.alpha = 1 - fabsf(movedRatio);
    }
}

- (void)viewPager:(ViewPagerController *)viewPager contentChangedToIndex:(NSUInteger)index
{
    NSLog(@"New title: %@", [self.viewPager.pages objectAtIndex:index]);
    self.navigationTitleView.label.text = [NSString stringWithFormat:@"Title: %@", [self.viewPager.pages objectAtIndex:index]];
    self.navigationTitleView.label.alpha = 1;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show Offer"] && [sender isKindOfClass:[GBOfferEssential class]]) {
        GBOfferViewController *newController = segue.destinationViewController;
        newController.offerId = ((GBOfferEssential *) sender).offerId;
        // send messages to newController to prepare it to appear on screen
        // the segue will do the work of putting the new controller on screen
    }
}

@end
