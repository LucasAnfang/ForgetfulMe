//
//  LocationDetailsTableViewController.m
//  Grip
//
//  Created by luke anfang on 12/6/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "LocationDetailsTableViewController.h"
#import "LocationDetailsModel.h"
#import "AddLocationDetailViewController.h"
#import "EditLocationDetailViewController.h"
@interface LocationDetailsTableViewController ()
@property (strong, nonatomic) LocationDetailsModel* locationDetailsModel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *UpdateButton;
@property NSInteger* selectedRowIndex;
@end

@implementation LocationDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationDetailsModel = [LocationDetailsModel sharedModel];
    if([self.locationDetailsModel numberOfLocationDetails] == 0) { //if there is no location details you cannot update anything
        [self.UpdateButton setEnabled:false];
    }
    self.selectedRowIndex = 0; //this is needed for selecting a row then pressing update defaults to 0
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //set left item to edit
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData]; //reload the data when the view appears
    [self.UpdateButton setEnabled:true];
    if([self.locationDetailsModel numberOfLocationDetails] == 0) { //check if there are Locationdetails to see if the update is possible
        [self.UpdateButton setEnabled:false];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //1 section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locationDetailsModel numberOfLocationDetails]; //number of rows
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
   
    // Configure the cell... //set the cell value with the title of the location detail at that index
    cell.textLabel.text = [[self.locationDetailsModel LocationDetailAtIndex:indexPath.row] title];
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete from model
        [self.locationDetailsModel removeLocationDetailAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedRowIndex = indexPath.row; //set the selected row
    NSLog(@"%@", [NSString stringWithFormat:@"Selected Row: %d",self.selectedRowIndex]);
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    EditLocationDetailViewController *eldvc = segue.destinationViewController;
    eldvc.originalTitle = [self.locationDetailsModel LocationDetailAtIndex:self.selectedRowIndex].title; //need to pass the title and description
    eldvc.originalDescription = [self.locationDetailsModel LocationDetailAtIndex:self.selectedRowIndex].locDescription;
    
    NSLog(@"Description %@ :: lat %@ :: long %@", [self.locationDetailsModel LocationDetailAtIndex:self.selectedRowIndex].locDescription,[self.locationDetailsModel LocationDetailAtIndex:self.selectedRowIndex].latitude,[self.locationDetailsModel LocationDetailAtIndex:self.selectedRowIndex].longitude); //error checking statement
    //edit completion handler :)
    eldvc.completionHandler = ^(NSString *title, NSString *description){
        if (title != nil && description != nil) {
            [self.locationDetailsModel updateWithTitle:title Description:description atIndex:self.selectedRowIndex];
            [self.tableView reloadData];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}


@end
