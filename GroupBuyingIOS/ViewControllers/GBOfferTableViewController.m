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

@interface GBOfferTableViewController() <GBApiOfferEssentialsTemplateDelegate>

@property (strong, nonatomic) NSMutableArray *offers; //of GBOfferEssential *

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
    [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:0 WithDelegate:self];
    [self.refreshControl addTarget:self action:@selector(refreshContent) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = UIColor.blueColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refreshContent
{
    [self.offers removeAllObjects];
    [self.tableView reloadData];
    [[GBApiOfferEssentialsTemplate sharedInstance] getOffersByCategory:@"shopping" AndPageNumber:0 WithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = self.title;
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
    [cell.titleLabel setText:((GBOfferEssential *)[self.offers objectAtIndex:indexPath.row]).title];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)getOfferEssentialsDidSucceedWithResults:(NSArray *)newOffers
{
    DLog(@"Yeahhhh2");
    [self.offers addObjectsFromArray:newOffers];
    [self.tableView reloadData];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (void)getOfferEssentialsDidFailWithError:(NSError *)error
{
    DLog(@"Oh no2!");
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

@end
