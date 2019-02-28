//
//  FacebookController.m
//  eAttendance
//
//  Created by Student on 12/3/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "FacebookController.h"

@interface FacebookController ()

@end

@implementation FacebookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
}
- (IBAction)facebookButtonPressed:(id)sender {
    
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];

}

- (void) fetchUserInfo:(NSString *)userID{
    
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
