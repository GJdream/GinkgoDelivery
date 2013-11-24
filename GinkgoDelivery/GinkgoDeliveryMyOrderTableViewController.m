//
//  GinkgoDeliveryMyOrderTableViewController.m
//  GinkgoDelivery
//
//  Created by Zihao Wang on 23/11/13.
//  Copyright (c) 2013 Zihao Wang. All rights reserved.
//

#import "GinkgoDeliveryMyOrderTableViewController.h"
#import "GinkgoDeliveryOrderInfoViewController.h"

@interface GinkgoDeliveryMyOrderTableViewController ()

@end

@implementation GinkgoDeliveryMyOrderTableViewController

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

-(void) validate {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array = [[defaults arrayForKey:@"localOrder"] mutableCopy];
    if(!array)
        array = [NSMutableArray array];
    PFQuery * checkKey = [PFQuery queryWithClassName:@"Order"];
    NSArray * allOrders =[checkKey findObjects];
    NSMutableArray * newarray = [NSMutableArray array];
    for(id each in array) {
        BOOL found = NO;
        for(PFQuery * eachOrder in allOrders) {
            if([[eachOrder valueForKey:@"objectId"] isEqualToString: each]) {
                found = YES;
                break;
            }
        }
        if(found) {
            [newarray addObject:each];
        }
    }
    [defaults setObject:newarray forKey:@"localOrder"];
    [defaults synchronize];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self validate];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array = [[defaults arrayForKey:@"localOrder"] mutableCopy];
    if(!array)
        array = [NSMutableArray array];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self validate];
    static NSString *CellIdentifier = @"MyOrder";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array = [[defaults arrayForKey:@"localOrder"] mutableCopy];
    if(!array)
        array = [NSMutableArray array];
    PFQuery * orderQuery = [PFQuery queryWithClassName:@"Order"];
    NSArray * allOrders = [orderQuery findObjects];
    if([array count] != 0) {
        PFObject * currentOrder = [allOrders objectAtIndex:indexPath.row];
        NSNumber * orderNumber = [currentOrder valueForKey:@"orderNo"];
        cell.textLabel.text = [orderNumber stringValue];
    }
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    static NSString *CellIdentifier = @"MyOrder";
    if([segue.identifier isEqualToString:@"Order Info"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedRowIndex];
        NSNumber * orderNumer = [NSNumber numberWithInt:[cell.textLabel.text integerValue]];
        [segue.destinationViewController setOrderNumber: orderNumer];
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
