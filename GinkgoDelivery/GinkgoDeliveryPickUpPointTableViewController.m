//
//  GinkgoDeliveryPickUpPointTableViewController.m
//  GinkgoDelivery
//
//  Created by Zihao Wang on 23/11/13.
//  Copyright (c) 2013 Zihao Wang. All rights reserved.
//

#import "GinkgoDeliveryPickUpPointTableViewController.h"
#import "GinkgoDeliveryConfirmationViewController.h"
#import "GinkgoDeliveryOrdersTableViewController.h"

@interface GinkgoDeliveryPickUpPointTableViewController ()

@end

@implementation GinkgoDeliveryPickUpPointTableViewController
@synthesize dish = _dish;
@synthesize query = _query;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.query = [PFQuery queryWithClassName:@"PickUpPoint"];
    NSLog(@"Found: %d matches", [self.query countObjects]);
    return [self.query countObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Places";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    self.query = [PFQuery queryWithClassName:@"PickUpPoint"];
    NSArray * allMatch = [self.query findObjects];
    cell.textLabel.text = [[allMatch objectAtIndex:indexPath.row] valueForKey:@"place"];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    static NSString *CellIdentifier = @"Places";
    if([segue.identifier isEqualToString:@"Pickup Point to Confirmation"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedRowIndex];
        [segue.destinationViewController setPickuppoint: cell.textLabel.text];
        [segue.destinationViewController setDish: self.dish];
    }

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

@end