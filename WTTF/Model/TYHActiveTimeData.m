//
//  WTTFActiveTimeData.m
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import "TYHActiveTimeData.h"
#import <CoreMotion/CoreMotion.h>
#import "TYHMeasures.h"

@implementation WTTFActiveTimeData{
    
    NSOperationQueue *operationQueue;
}

- (NSMutableArray *) getActivityArray{
    
    NSDate *now               = [[NSDate alloc] init];
    CMMotionActivityManager * activity = [[CMMotionActivityManager alloc] init];
    operationQueue = [[NSOperationQueue alloc] init];
    NSMutableArray *activityVector = [[NSMutableArray alloc] init];
    
    
    dispatch_group_t configGroup = dispatch_group_create();
    dispatch_group_enter(configGroup); // 1st Routine
    
    [activity queryActivityStartingFromDate:[WTTFMeasures getToday] toDate:now toQueue:operationQueue withHandler:^(NSArray *activities, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"An error recording activities ocurred");
            }else{
                
                for (int i=0; i<activities.count; i++) {

                    CMMotionActivity *item = activities[i];
                    CMMotionActivity *nextItem = activities[i+1];
                    
                    /*!
                     *  Item Name stage
                     */
                    
                    NSString *itemName;
                    
                    if (item.walking == 1) {
                        
                        itemName = @"walking";
                        
                    }else if (item.running == 1){
                        
                        itemName = @"running";
                        
                    }else if (item.cycling == 1){
                        
                        itemName = @"cycling";
                        
                    }else if (item.automotive == 1){
                        
                        itemName = @"automotive";
                        
                    }else if (item.stationary == 1){
                        
                        itemName = @"stationary";
                        
                    }else{
                        
                        itemName = @"unknown";
                        
                    }
                    
                    /*!
                     *  Confidence Stage
                     */
                    
                    NSString *confidence;
                    
                    if (item.confidence == CMMotionActivityConfidenceHigh) {
                        
                        confidence = @"high";
                        
                    }else if(item.confidence == CMMotionActivityConfidenceMedium){
                        
                        confidence = @"medium";
                    }else{
                        
                        confidence = @"low";
                    }
                    
                    /*!
                     *  Item time Stage
                     */
                    
                    NSTimeInterval duration;
                    
                    if (i == activities.count-1) {
                        
                        NSDate *now = [[NSDate alloc] init];
                        duration = [nextItem.startDate timeIntervalSinceDate:now];
                    }else{
                        
                        duration = [nextItem.startDate timeIntervalSinceDate:item.startDate];
                        
                    }
                    
                    
                    /*!
                     *  Create Dummy Array, the vector is organized on Name, duration, confidence
                     */
                    
                    NSArray *dummyArray = @[itemName, [NSNumber numberWithDouble:duration], confidence];
                    
                    [activityVector addObject:dummyArray];
                    
                    dispatch_group_leave(configGroup);
                    
                    
                }
                
                
            }

        });
        

        
    }];
    
    dispatch_group_wait(configGroup,DISPATCH_TIME_FOREVER);
    
    return activityVector;
    
}


/*!
 *  Gets an array with the Activity duration totals
 *
 *  @return NSArray(Active time, Stationary time, total time)
 */

- (NSArray *)getActivityStatus{
    
    NSMutableArray *activityVector = [self getActivityArray];
    
    NSNumber *activeTime = @(0);
    NSNumber *stationarytime = @(0);
    NSNumber *totalTime = @(0);
   // NSNumber *unknownTime = @(0);
    
    
    //Only results of confidence High or Medium are considered
    
    for (NSArray *item in activityVector){
        
        NSNumber  *duration = item[1];
        
        totalTime = [NSNumber numberWithInt:[totalTime intValue] + [duration intValue]];
        
        if ([item[0] isEqual:@"walking"] | [item[0] isEqual:@"running"] | [item[0] isEqual:@"cycling"] && [item[2] isEqual:@"high"] | [item[2] isEqual:@"medium"] ) {
            
            activeTime = [NSNumber numberWithInt:[activeTime intValue] + [duration intValue]];
            
        }else{
            
            stationarytime = [NSNumber numberWithInt:[stationarytime intValue] + [duration intValue]];
            
        }
        
            
        }
    
    return [NSArray arrayWithObjects:activeTime, stationarytime, totalTime , nil];
    
    }





@end

