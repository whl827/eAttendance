//
//  AddViewController.h
//  eAttendance
//
//  Created by Woonghee on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

// typedefBlock
typedef void(^AddInfo)(NSString *input1, NSString *input2, NSString *input3, NSString *input4);
@interface AddViewController : UIViewController <UITextFieldDelegate>

// public property
@property (copy, nonatomic) AddInfo addInfo;

@property (strong, nonatomic) NSString *placeholderInput1;

@end
