//
//  TableViewController.m
//  eAttendance
//
//  Created by Student on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "TableViewController.h"


#import "RegisteredClassModel.h"
#import "AddViewController.h"
#import "ValidateLocationController.h"
#import "TakePhotoController.h"
#import "SuccessController.h"

@interface TableViewController ()

@property (strong, nonatomic) RegisteredClassModel *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *takeAttendanceButton;

@property (strong, nonatomic) UITableViewCell *current_cell;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.dataModel = [RegisteredClassModel sharedModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [self.dataModel numberOfRegisteredClass];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    // Display based on the row number
    // Get row number from indexPath
    NSString *tableCellText;
    //tableCellText = [NSString stringWithFormat:@"Row %li", (long)indexPath.row];
    RegisteredClass *class = [self.dataModel classAtIndex: indexPath.row];
    tableCellText = [NSString stringWithFormat:
                     @"%@", [class title]];
    cell.textLabel.text = tableCellText;
    cell.textLabel.numberOfLines = 0;
    
    
    
    return cell;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.dataModel removeClassAtIndex: indexPath.row];
        
        //if Empty, disable attendance button
        if([self.dataModel numberOfRegisteredClass] == 0){
            _takeAttendanceButton.enabled = NO;
        }else{
            _takeAttendanceButton.enabled = YES;
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    
    NSString* segue_name = segue.identifier;
    if([segue_name  isEqualToString: @"AddCourseSegue"]){
        
        AddViewController *addVC = [segue destinationViewController];
        
        // set public property placeholderInput1
        addVC.placeholderInput1 = @"Question";
        
        // set completion block for AddViewController
        addVC.addInfo = ^(NSString *title, NSString *location, NSString *time, NSString *day) {
            if (title.length > 0 && location.length > 0 && time.length > 0 && day.length > 0) {
                // add student to model
                //[self.dataModel addStudentWithFirstName:firstN lastName:lastN age:ageStr.integerValue];
                [self.dataModel insertWithTitle:title location:location time:time day:day];
                // update table view
                [self.tableView reloadData];
                
                _takeAttendanceButton.enabled = YES;

            }
            // Make the view controller go away
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
    }else if([segue_name isEqualToString:@"TakeAttendanceSegue"]){
        
        RegisteredClass *selectedClass = [self.dataModel classAtIndex:_rowNo];
        
        ValidateLocationController *vlc = [segue destinationViewController];
        
        vlc.selectedClass = selectedClass;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    // Pass the selected object to the new view controller.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _rowNo = (int)indexPath.row;
    _current_cell = [tableView cellForRowAtIndexPath:indexPath];
}

- (IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue {

    //this is when it was successfully checked in: PUT CHECK MARK
    if([unwindSegue.sourceViewController isKindOfClass:[SuccessController class]]){
        _current_cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}



@end
