//
//  WFFTStepTrackerViewController.m
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import "TYHStepTrackerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface WFFTStepTrackerViewController ()

@end

@implementation WFFTStepTrackerViewController{
    
    NSDate *now;
    NSDate *thisTimeYesterday;
    NSDate *today;
}


- (void)startPedometer{
   
    if ([CMPedometer isStepCountingAvailable] | [CMPedometer isDistanceAvailable] ) {
        self.pedometerData = [[CMPedometer alloc] init];
        
        /*!
         *  Date Declarations
         */
        
        now               = [[NSDate alloc] init];
        thisTimeYesterday         = [NSDate dateWithTimeIntervalSinceNow:-3600*24];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
        
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
        
        
        
        
    } else {
        NSLog(@"No pedometer data available. Device not compatible");
    }
    
    
    
}

- (void)getTodaySteps {
    
    [self.pedometerData startPedometerUpdatesFromDate:today withHandler:^(CMPedometerData *pedometerData, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

        if (error) {
            NSLog(@"[getTodaySteps] No Pedometer data Avaliable");
        }else{
            
            NSString *someValeu = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];
        }
        
        });
    }];
     
    
    
    
  
    
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

- (BOOL) checksIfDataAvailable {
    
    if ([CMPedometer isStepCountingAvailable] | [CMPedometer isDistanceAvailable] ){
        
        NSLog(@"Device IS able to track steps and distance");
        
        return YES;
    } else {
        
        NSLog(@"Device is NOT able to track steps and distance");
        
        return NO;
    }
    
}


- (void) getCurrentStepCount{
    
    
}

@end
