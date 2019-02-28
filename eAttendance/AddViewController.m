//
//  AddViewController.m
//  eAttendance
//
//  Created by Woonghee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UITextField *TimeText;
@property (weak, nonatomic) IBOutlet UITextField *dayText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self enableSaveButtonForInput1:self.titleText.text
                             input2: self.locationText.text
                             input3: self.TimeText.text
                             input4: self.dayText.text];
    
    _titleText.delegate = self;
    _locationText.delegate = self;
    _TimeText.delegate = self;
    _dayText.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [_titleText becomeFirstResponder];
}

- (IBAction)cancelButtonTapped:(id)sender {
    if (self.addInfo) {
        self.addInfo(nil, nil, nil, nil);
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    if (self.addInfo) {
        self.addInfo(self.titleText.text,
                     self.locationText.text,
                     self.TimeText.text,
                     self.dayText.text);
    }
    self.titleText.text = nil;
    self.locationText.text = nil;
    self.TimeText.text = nil;
    self.dayText.text = nil;
    
}

- (BOOL)textFieldShouldEndEditing:(id)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(id)textField {
    [textField resignFirstResponder];
    return YES;
}		

//Whenever you change input
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range
                                                                      withString:string];
    
    if (textField == self.titleText) {
        [self enableSaveButtonForInput1:changedString input2:self.locationText.text input3: self.TimeText.text input4: self.dayText.text];
    } else if (textField == self.locationText) {
        [self enableSaveButtonForInput1:self.titleText.text input2:changedString input3: self.TimeText.text input4: self.dayText.text];
    } else if (textField == self.TimeText) {
        [self enableSaveButtonForInput1:self.titleText.text input2:self.locationText.text input3: changedString input4: self.dayText.text];
    } else {
        [self enableSaveButtonForInput1:self.titleText.text input2:self.locationText.text input3: self.TimeText.text input4: changedString];
    }
    
    return YES;
}

// Enabled the save button when data is in all 3 textfields
- (void) enableSaveButtonForInput1: (NSString *) tf1
                            input2: (NSString *) tf2
                            input3: (NSString *) tf3
                            input4: (NSString *) tf4{
    self.saveButton.enabled = (tf1.length > 0 && tf2.length > 0 && tf3.length > 0 && tf4.length > 0);
}

- (IBAction)BackgroundButtontouched:(id)sender {
    
    [self.titleText resignFirstResponder];
    [self.locationText resignFirstResponder];
    [self.TimeText resignFirstResponder];
    [self.dayText resignFirstResponder];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
