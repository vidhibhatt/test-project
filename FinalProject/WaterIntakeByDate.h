//
//  WaterIntakeByDate.h
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaterIntakeByDate : NSObject

// Daily goal for the user
@property int goal;

//  User's intake
@property int intake;

// progress percent
@property float progress;

// today's date
@property NSDate *todayDate;

// currently selected date
@property NSDate *currentDate;


// initializer
-(id)initWithGoal: (int) goal andIntake:(int) intake andProgress:(float) progress andTodayDate:(NSDate *) today;

// methods
-(void)addIntake;

-(void)removeIntake;

-(void) nextDatePressed: (NSDate *) selectedDate;

-(void) previousDatePressed: (NSDate *) selectedDate;

-(void) loadData: (NSDate *) currentDate;

@end
