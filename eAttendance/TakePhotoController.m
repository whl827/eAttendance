//
//  TakePhotoController.m
//  eAttendance
//
//  Created by Student on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "TakePhotoController.h"

@interface TakePhotoController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation TakePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.imageView.image == nil){
        self.doneButton.enabled = NO;
    }else{
        self.doneButton.enabled = YES;
    }
//    if(self.imageView == nil){
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
//        imagePickerController.delegate = self;
//        [self presentViewController:imagePickerController animated:NO completion:nil];
//    }else{
//        
//    }

}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:NO completion:nil];
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
