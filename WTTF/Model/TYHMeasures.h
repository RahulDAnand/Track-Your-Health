//
//  WTTFMeasures.h
//  TYH
//
//  Created by Rahul Anand on 10/01/2017.
//  Copyright (c) 2017 rahulanand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTTFMeasures : NSObject

/*!
 *  Gets how much/less the user surpassed/missed yesterday's distance
 */
@property (nonatomic, copy) NSString *pastSelfData;

/*!
 *  Gets how much of the user's goal is completed
 */
@property (nonatomic, copy) NSString *questData;

/*!
 *  Gets how much the user has remained active during the day
 */
@property (nonatomic, copy) NSString *activeTimeData;


@property (nonatomic, copy) NSDate *today;

@property (nonatomic, copy) NSDate *yesterday;



+ (NSDate *)getToday;
+ (NSDate *)getYesterday;


//- (NSDate *)computePastDateWithDay:(int)day;


/*!
 *  Computes how much/less the user surpassed/missed yesterday's distance
 *
 *  @param pastData Past(yesterday) distance data
 */
- (NSString *) computePastSelfWithPastData:(NSNumber *)pastData andPresentData:(NSNumber *)presentData;


/*!
 *  Computes how much percentage of Today's Quest is completed
 *
 *  @param aQuestData Today's Quest
 */
- (NSString *) computeQuestWithGoal:(float)aQuestData andTodayData:(NSNumber *)todayData;

/*!
 *  Computes how much time (in percentage) the user has remainded active
 *  during the day.
 *
 */



@end
