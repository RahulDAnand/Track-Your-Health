//
//  WTTFMainViewController.m
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import "TYHMainViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface WTTFMainViewController ()

@end

@implementation WTTFMainViewController{
    
    NSNumber *yesterdayData;
    NSNumber *todayData;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
    
    // Do any additional setup after loading the view.
    self.pedometerData        = [[CMPedometer alloc] init];

    
    
    
    /*!
     *  Define Days
     *
     */
    
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    
    int day = 3600*24;
    
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
    NSDate *now               = [[NSDate alloc] init];
    NSDate *yesterday         = [NSDate dateWithTimeInterval:-day sinceDate:today];
    
    
    /*!
     *  Gets today Steps
     */

    if ([CMPedometer isStepCountingAvailable] | [CMPedometer isDistanceAvailable]){
        
        //In case is available
        
        NSLog(@"YES is available!");

        [self.pedometerData startPedometerUpdatesFromDate:today withHandler:^(CMPedometerData *pedometerData, NSError *error) {
            

            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"Pedometer is NOT available.");
                }
                else {
                    NSLog(@"Entering the pedometer data NOW %@", pedometerData);
                    self.stepsLabel.text = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];
                }
            });

                }];
        

        /*!
         *  Queries distance data for this day
         *
         */
        
        [self.pedometerData queryPedometerDataFromDate:today toDate:now withHandler:^(CMPedometerData *pedometerData, NSError *error) {


            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"Pedometer is NOT available.");
                }
                else {
                    NSLog(@"Entering the pedometer data YESTERDAY %@", pedometerData);
                    
                    NSNumberFormatter* format = [[NSNumberFormatter alloc] init];
                    [format setNumberStyle:NSNumberFormatterDecimalStyle];
                    [format setPositiveFormat:@"0.##"];
                    
                    
                    NSNumber *kilometers = @([pedometerData.distance floatValue]/1000);
                    
                    self.stepsYesterday.text = [NSString stringWithFormat:@"%@", [format stringFromNumber:kilometers]];
                }
            });

        }];

              }else{
                  NSLog(@"Damn... it doesn't works");
              }
    
    // this is location map

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //test
    // we have to setup the location maanager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

@end
