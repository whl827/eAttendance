//
//  ValidateLocationController.h
//  eAttendance
//
//  Created by Student on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteredClass.h"
#import <MapKit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>

@interface ValidateLocationController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *photoButton;

@property (strong, nonatomic) RegisteredClass *selectedClass;

@end
