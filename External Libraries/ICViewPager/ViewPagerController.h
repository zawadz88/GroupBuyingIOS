//
//  ViewPagerController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent
};

@protocol ViewPagerDataSource;
@protocol ViewPagerDelegate;
@protocol ViewPagerIndicatorDelegate;

@interface ViewPagerController : UIViewController

@property id<ViewPagerDataSource> dataSource;
@property id<ViewPagerDelegate> delegate;
@property NSMutableArray *indicators; //of id<ViewPagerIndicatorDelegate>

@property (nonatomic, readonly) NSUInteger activeTabIndex;
@property (readonly) NSUInteger tabCount;

#pragma mark Colors
// Colors for several parts
@property UIColor *contentViewBackgroundColor;

#pragma mark Methods
// Reload all tabs and contents
- (void)reloadData;

@end

#pragma mark dataSource
@protocol ViewPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(ViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

#pragma mark delegate
@protocol ViewPagerDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;

/*
 * Use this method to customize the look and feel.
 * viewPager will ask its delegate for colors for its components.
 * And if they are provided, it will use them, otherwise it will use default colors.
 * Also not that, colors for tab and content views will change the tabView's and contentView's background 
 * (you should provide these views with a clearColor to see the colors),
 * and indicator will change its own color.
 */
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color;
@end

#pragma mark indicator delegate
@protocol ViewPagerIndicatorDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when content is being scrolled
- (void)viewPager:(ViewPagerController *)viewPager contentChangedToIndex:(NSUInteger)index;

// delegate object must implement this method if wants to be informed when content is being scrolled
- (void)viewPager:(ViewPagerController *)viewPager contentMovedByRatio:(CGFloat)movedRatio;
@end
