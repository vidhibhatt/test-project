//
//  WaterIntakeByDate.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "WaterIntakeByDate.h"

@implementation WaterIntakeByDate

// initializer
-(id)initWithGoal: (int) goal andIntake:(int) intake andProgress:(float) progress andTodayDate:(NSDate *) today{
    _goal = goal;
    _intake = intake;
    _progress = progress;
    _todayDate = today;
    return self;
}

// methods
-(void)addIntake{
    _intake = _intake + 1;
    _progress = (_intake/_goal) * 100;
}

-(void)removeIntake{
    if (_intake != 0){
        _intake = _intake - 1;
        _progress = (_intake/_goal) * 100;
    }
}

-(void) nextDatePressed: (NSDate *) selectedDate{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate: selectedDate options:0];
    _currentDate = nextDate;

}

-(void) previousDatePressed: (NSDate *) selectedDate{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate: selectedDate options:0];
    _currentDate = nextDate;
}


-(void) loadData: (NSDate *) currentDate{
    //reload view
}

@end
