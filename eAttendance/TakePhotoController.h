//
//  TakePhotoController.h
//  eAttendance
//
//  Created by Student on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
