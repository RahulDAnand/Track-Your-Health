//
//  WFFTStepTrackerViewController.h
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface WFFTStepTrackerViewController : UIViewController

@property (nonatomic, strong) CMPedometer *pedometerData;

@property (nonatomic, strong) NSString * currentSteps;

@end
