//
//  ValidateLocationController.m
//  eAttendance
//
//  Created by Student on 12/2/17.
//  Copyright © 2017 Woonghee Lee. All rights reserved.
//

#import "ValidateLocationController.h"
#import <GoogleMaps/GoogleMaps.h>

//Class               Lat                Long
//Viterbi         34.020359          -118.288819
//Marshall        34.018830          -118.285782
//Art             34.023454          -118.287156
//Thorton         34.023125          -118.285450
//Annenberg       34.022120          -118.286136

@interface ValidateLocationController () <MKMapViewDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet GMSMapView *googleMapView;

@property (nonatomic, strong) NSMutableArray* buildings;
@property (nonatomic, strong) NSMutableArray* buildingsLat;
@property (nonatomic, strong) NSMutableArray* buildingsLong;

@end

float selectedBuildingLatitude;
float selectedBuildingLongitude;
float userLocationLatitude;
float userLocationLongitude;

@implementation ValidateLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view sendSubviewToBack:_mapView];
    
    
    // Do any additional setup after loading the view.
    
    //lat for 5 buildings
    NSNumber *lat1 = [NSNumber numberWithFloat:34.020359f];
    NSNumber *lat2 = [NSNumber numberWithFloat:34.018830f];
    NSNumber *lat3 = [NSNumber numberWithFloat:34.023454f];
    NSNumber *lat4 = [NSNumber numberWithFloat:34.023125f];
    NSNumber *lat5 = [NSNumber numberWithFloat:34.022120f];
    //long for 5 buildings
    NSNumber *long1 = [NSNumber numberWithFloat:-118.288819f];
    NSNumber *long2 = [NSNumber numberWithFloat:-118.285782f];
    NSNumber *long3 = [NSNumber numberWithFloat:-118.287156f];
    NSNumber *long4 = [NSNumber numberWithFloat:-118.285450f];
    NSNumber *long5 = [NSNumber numberWithFloat:-118.286136f];
    
    //name for 5 buildings
    _buildings = [NSMutableArray arrayWithObjects:@"Viterbi",@"Marshall",@"Art",@"Thorton",@"Annenberg", nil];
    _buildingsLat = [NSMutableArray arrayWithObjects:lat1,lat2,lat3,lat4,lat5, nil];
    _buildingsLong = [NSMutableArray arrayWithObjects:long1,long2,long3,long4,long5,nil];
    
    //Find the building's long, lat for currently selected class
    NSString *selectedClassLocation = _selectedClass.location;
    NSArray* location = [selectedClassLocation componentsSeparatedByString: @" "];
    NSString* selectedBuildingName = [location objectAtIndex: 0];
    
    int index = (int)[_buildings indexOfObject:selectedBuildingName];
    //Building not found
    if(index == -1){
        _resultLabel.text = @"Class Building Cannot Be Verified";
        return;
    }
    
    NSNumber *comparingLat = [_buildingsLat objectAtIndex:index];
    NSNumber *comparingLong = [_buildingsLong objectAtIndex:index];
    
    float latResult = [comparingLat floatValue];
    float longResult = [comparingLong floatValue];
    
    //store lat, long to compare to user location
    selectedBuildingLatitude = latResult;
    selectedBuildingLongitude = longResult;

    //Show map
    _mapView.showsUserLocation = YES;
    _mapView.showsBuildings = YES;
    
    //google map
    locationManager = [[CLLocationManager alloc] init];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];

}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate: userLocation.coordinate
                                                     fromEyeCoordinate: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) eyeAltitude:10000];
    [mapView setCamera:camera animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        //Keep Updating User Location
        userLocationLatitude = currentLocation.coordinate.latitude;
        userLocationLongitude = currentLocation.coordinate.longitude;
        
// Method to check the current location and compare with the class lon & lat
//        //Compare User Location to Building Location (Relative close)
//        if(userLocationLatitude < selectedBuildingLatitude + 0.00005 &&
//           userLocationLatitude > selectedBuildingLatitude - 0.00005 &&
//           userLocationLongitude < selectedBuildingLongitude + 0.00005 &&
//           userLocationLongitude > selectedBuildingLongitude - 0.00005){
//            _resultLabel.text = @"Location Verified! Please Continue";
//            _photoButton.enabled = YES;
//        }else{
//            _resultLabel.text = @"Not In Range! Please Retry";
//            _photoButton.enabled = NO;
//        }
        
        _resultLabel.text = @"Location Verified! Please Continue";
        _photoButton.enabled = YES;
    }
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:1000];
    self.googleMapView.camera = camera;
    
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
