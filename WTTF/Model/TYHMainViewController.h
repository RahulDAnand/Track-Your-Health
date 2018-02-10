//
//  WTTFMainViewController.h
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WTTFMainViewController : UIViewController

<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}


@property (weak, nonatomic  ) IBOutlet UILabel          *stepsLabel;
@property (weak, nonatomic  ) IBOutlet UILabel          *stepsYesterday;
@property (strong, nonatomic)          CMPedometer      *pedometerData;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;
@property (weak, nonatomic) IBOutlet UILabel *labelAltitude;






@end
