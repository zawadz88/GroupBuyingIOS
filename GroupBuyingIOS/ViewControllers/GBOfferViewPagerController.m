//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "GBOfferViewPagerController.h"
#import "GBOfferTableViewController.h"

#define DEFAULT_PAGE_COUNT
@interface GBOfferViewPagerController () <ViewPagerDataSource, ViewPagerDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation GBOfferViewPagerController

- (void)setPages:(NSMutableArray *)pages {
    _pages = pages;
    self.pageControl.numberOfPages = [pages count];
}

- (void)viewDidLoad {
    NSLog(@"Child loading");
    self.dataSource = self;
    self.delegate = self;
    [self.indicators addObject:self];
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
    NSLog(@"Child loaded with parent: %@", self.parentViewController);
    self.pageControl.numberOfPages = 1;
    self.pageControl.currentPage = 0;
    self.pageControl.alpha = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [self.pages count];
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    GBOfferTableViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"GBOfferTableViewController"];
    cvc.parentVC = self.parentViewController;
    
    return cvc;
}
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    self.pageControl.currentPage = index;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor magentaColor] colorWithAlphaComponent:0.64];
            break;
        case ViewPagerTabsView:
            return [[UIColor blueColor] colorWithAlphaComponent:0.64];
            break;
        case ViewPagerContent:
            return [[UIColor yellowColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

- (void)viewPager:(ViewPagerController *)viewPager contentMovedByRatio:(CGFloat)movedRatio
{
    if (movedRatio == 0) {
        [UIView animateWithDuration:0.5
                              delay:1.0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^(void) {
                             self.pageControl.alpha = 0;
                         }
                         completion:nil];

    } else {
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^(void) {
                             self.pageControl.alpha = 1;
                         }
                         completion:nil];
    }
}

@end
