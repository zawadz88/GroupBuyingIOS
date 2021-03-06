//
//  GBOfferTableViewController.m
//  GroupBuyingIOS
//
//  Created by Piotr Zawadzki on 29.09.2013.
//  Copyright (c) 2013 Piotr Zawadzki. All rights reserved.
//

#import "GBOfferTableViewController.h"
#import "GBOfferTableViewCell.h"
#import "GBApiOfferEssentialsTemplate.h"
#import "GBRefreshFooterView.h"
#import "GBLoadingFooterView.h"
#import "GBOfferViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+MultiFormat.h"

#define OFFERS_PAGE_SIZE 10

#define HEIGHT_FROM_BOTTOM_TO_FETCH_NEW_OFFERS 600
#define FOOTER_VIEW_HEIGHT 60
#define FOOTER_VIEW_WIDTH 320

#define CUSTOM_CELL_ZOOM_X_SCALE_FACTOR 1.5
#define CUSTOM_CELL_ZOOM_Y_SCALE_FACTOR 1.2

@interface GBOfferTableViewController() <GBApiOfferEssentialsTemplateDelegate, GBRefreshFooterViewDelegate>

@property (strong, nonatomic) NSMutableArray *offers; //of GBOfferEssential *

@property (atomic) BOOL isLoading;
@property (atomic) BOOL moreOffersAvailable;
@property (atomic) NSInteger currentPage;
@property (atomic) BOOL internetAvailable;

@end

@implementation GBOfferTableViewController


- (NSArray *) offers
{
    if (!_offers) {
        _offers = [[NSMutableArray alloc] init];
    }
    return _offers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cellZoomXScaleFactor = [NSNumber numberWithDouble:CUSTOM_CELL_ZOOM_X_SCALE_FACTOR];
    self.cellZoomYScaleFactor = [NSNumber numberWithDouble:CUSTOM_CELL_ZOOM_Y_SCALE_FACTOR];
    
    self.isLoading = YES;
    self.internetAvailable = YES;
    self.moreOffersAvailable = YES;
    self.currentPage = -1;
    [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:(self.currentPage + 1) WithDelegate:self];
    [self.refreshControl addTarget:self action:@selector(refreshContent) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = UIColor.blueColor;
}

- (void)refreshContent
{
    self.tableView.tableFooterView = nil;
    self.isLoading = YES;
    self.moreOffersAvailable = YES;
    self.internetAvailable = YES;
    self.currentPage = -1;
    [self.offers removeAllObjects];
    [self.tableView reloadData];
    [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:(self.currentPage + 1)  WithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.offers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Offer Cell";
    GBOfferTableViewCell *cell = (GBOfferTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    GBOfferEssential *offer = (GBOfferEssential *)[self.offers objectAtIndex:indexPath.row];
    [cell.titleLabel setText:offer.title];
    [cell.imageView setImageWithURL:[NSURL URLWithString:offer.imageUrl]
                   placeholderImage:[UIImage imageNamed:@"image_stub.jpg"]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              cell.imageView.image = [image imageByScalingAndCroppingForSize:CGSizeMake(OFFER_ESSENTIAL_CELL_WIDTH, OFFER_ESSENTIAL_CELL_HEIGHT)];
                          }];
    
    return cell;
}

- (void)getOfferEssentialsDidSucceedWithResults:(NSArray *)newOffers
{
    DLog(@"Yeahhhh2");
    self.isLoading = NO;
    self.internetAvailable = YES;
    if(!newOffers || [newOffers count] < OFFERS_PAGE_SIZE) {
        self.moreOffersAvailable = NO;
    }
    self.currentPage++;
    [self.offers addObjectsFromArray:newOffers];
    [self.tableView reloadData];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
    self.tableView.tableFooterView = nil;
}

- (void)getOfferEssentialsDidFailWithError:(NSError *)error
{
    DLog(@"Oh no2!");
    self.internetAvailable = NO;
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }

    CGRect footerRect = CGRectMake(0, 0, FOOTER_VIEW_WIDTH, FOOTER_VIEW_HEIGHT);
    GBRefreshFooterView * tableFooter = [[GBRefreshFooterView alloc] initWithFrame:footerRect];
    self.tableView.tableFooterView = tableFooter;
    tableFooter.delegate = self;
    self.isLoading = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.offers count] > 0 && self.internetAvailable && !self.isLoading && self.moreOffersAvailable) {
        
        CGFloat actualPosition = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height - HEIGHT_FROM_BOTTOM_TO_FETCH_NEW_OFFERS;
        if (actualPosition >= contentHeight) {
            NSLog(@"fetching some new content...");
            self.isLoading = YES;
            [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:(self.currentPage + 1) WithDelegate:self];
            
            CGRect footerRect = CGRectMake(0, 0, FOOTER_VIEW_WIDTH, FOOTER_VIEW_HEIGHT);
            GBLoadingFooterView * tableFooter = [[GBLoadingFooterView alloc] initWithFrame:footerRect];
            self.tableView.tableFooterView = tableFooter;
        }
    }
}

- (void) refreshFooterClicked
{
    CGRect footerRect = CGRectMake(0, 0, FOOTER_VIEW_WIDTH, FOOTER_VIEW_HEIGHT);
    GBLoadingFooterView * tableFooter = [[GBLoadingFooterView alloc] initWithFrame:footerRect];
    self.tableView.tableFooterView = tableFooter;
    self.isLoading = YES;
    self.internetAvailable = YES;
    [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:(self.currentPage + 1) WithDelegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    GBOfferEssential *selectedOffer = [self.offers objectAtIndex:indexPath.row];
    [self.parentVC performSegueWithIdentifier:@"Show Offer" sender:selectedOffer];
}

@end
