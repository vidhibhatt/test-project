//
//  DashboardViewController.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "DashboardViewController.h"
#import "SWRevealViewController.h"
#import "WaterIntakeByDate.h"
#import "DBManager.h"
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface DashboardViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrWaterInfo;

-(void)loadData;

@end

@implementation DashboardViewController{
    WaterIntakeByDate *currentIntakeObject;
    NSDate *today;
    NSDate *currentDate;
    int currentIntake;
    float currentSuccess;
    NSMutableArray *existingDateKeysInDB;
    NSDateFormatter *dateFormatter;
    BOOL isUpdateQuery;
    // index of a date in the result array. This is for quicker search
    NSMutableDictionary *dateAndIndex;
    // current int to display
    NSNumber *currentIndexInResults;
    BAFluidView *fluidview;
    NSString *query;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [_barButton setTarget: self.revealViewController];
        [_barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    today = [NSDate date];
    currentDate = today;
    existingDateKeysInDB = [[NSMutableArray alloc] init];
    dateAndIndex = [[NSMutableDictionary alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    isUpdateQuery = NO;
    currentIndexInResults = [[NSNumber alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentIntakeObject = [[WaterIntakeByDate alloc] initWithGoal:8 andIntake:0 andProgress:0 andTodayDate: [self dateFormatter:today]];
    
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    [self loadData];
    [self setupFluidView];
    
}

-(void) setupFluidView{
    fluidview = [[BAFluidView alloc] initWithFrame:self.view.frame];
    fluidview.fillRepeatCount = 1;
    fluidview.fillAutoReverse = NO;
    [fluidview fillTo:@0.02];
    fluidview.fillColor = [UIColor colorWithHex:0x397ebe];
    [fluidview startAnimation];
    [self.view addSubview:fluidview];
}


- (IBAction)addPressed:(UIButton *)sender {
    isUpdateQuery = NO;
    //[currentIntakeObject addIntake];
    [self addIntake];
    
    //check if record is present. If true, use update query.
    // if false, use intsert query.
    if([self isRecordPresent]){
        // Update query
        query = [self getUpdateQueryString];
    } else{
        query = [self getInsertQueryString];
    }
    [self insertANewRecord];
    [self changeFluidViewLevel:currentIntake];
    
    // update view
    _intakeLabel.text = [NSString stringWithFormat: @"%d", currentIntake];
     _successLabel.text = [NSString stringWithFormat: @"%f", currentSuccess];
}

- (IBAction)removePressed:(UIButton *)sender {
    isUpdateQuery = NO;
    [currentIntakeObject removeIntake];
    _intakeLabel.text = [NSString stringWithFormat: @"%d", currentIntakeObject.intake];
    _successLabel.text = [NSString stringWithFormat: @"%f", currentIntakeObject.progress];
    [self changeFluidViewLevel:currentIntake];
    
}


- (IBAction)nextDatePressed:(UIButton *)sender {
    [currentIntakeObject nextDatePressed:currentDate];
    NSString        *dateString;
    
    dateString = [dateFormatter stringFromDate:currentIntakeObject.currentDate];
    _currentDateLabel.text = dateString;
    // change current date
    currentDate = currentIntakeObject.currentDate;
    
    // if current date is greater than today, disable add and remove
    if ([self isDayGreaterThanToday:currentDate]){
        // todo: diable add, remove
        printf("Day greatter");
    } else {
        if (self.isRecordPresent){
            // update view
            [self getCurrentIntakeAndSuccess];
        }
        else{
            currentIntake = 0;
            currentSuccess = 0.0f;
        }

    }
    _intakeLabel.text = [NSString stringWithFormat:@"%d",currentIntake];
    _successLabel.text = [NSString stringWithFormat: @"%f", currentSuccess];
}

- (IBAction)prevDatePressed:(UIButton *)sender {
    [currentIntakeObject previousDatePressed:currentDate];
    NSString        *dateString;
    dateString = [dateFormatter stringFromDate:currentIntakeObject.currentDate];
    _currentDateLabel.text = dateString;
    // change current date
    currentDate = currentIntakeObject.currentDate;
    // if current date is greater than today, disable add and remove
    if ([self isDayGreaterThanToday:currentDate]){
        // todo: diable add, remove
        printf("Day greatter");
    } else {
        if (self.isRecordPresent){
            // update view
            [self getCurrentIntakeAndSuccess];            
        }
        else{
            currentIntake = 0;
            currentSuccess = 0.0f;
        }
    }
    _intakeLabel.text = [NSString stringWithFormat:@"%d",currentIntake];
    _successLabel.text = [NSString stringWithFormat: @"%f", currentSuccess];

}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from waterIntake";
    
    // Get the results.
    if (self.arrWaterInfo != nil) {
        self.arrWaterInfo = nil;
    }
    self.arrWaterInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    //for (id intake in self.arrWaterInfo){
    for (int f = 0; f < [self.arrWaterInfo count]; f++) {
        // value is the index and key is Date string
        [dateAndIndex setObject:[NSNumber numberWithInt:f] forKey:[[self.arrWaterInfo objectAtIndex:f]objectAtIndex:0]];
        [existingDateKeysInDB addObject:[[self.arrWaterInfo objectAtIndex:f]objectAtIndex:0]];
    }
}

-(NSDate *)dateFormatter: (NSDate *) date{
    return [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
}

- (BOOL)isDayGreaterThanToday:(NSDate*)date1 {
    NSComparisonResult result;
    result = [[dateFormatter stringFromDate:today] compare:[dateFormatter stringFromDate:date1]];
    return (result==NSOrderedAscending);
}

- (BOOL)isRecordPresent {
    BOOL isTheObjectThere = NO;
    for (id dateKey in dateAndIndex){
    if ([[dateFormatter stringFromDate:currentDate] isEqualToString:dateKey]) {
         isTheObjectThere = YES;
        currentIndexInResults = [dateAndIndex valueForKey:dateKey];
        isUpdateQuery = YES;
         break;
        }
     }
    return isTheObjectThere;
}

-(void)getCurrentIntakeAndSuccess{
    // get the row number for the currently selected date
    int i = [currentIndexInResults intValue];
    // get the contents of the row in array
    NSArray *test = [self.arrWaterInfo objectAtIndex:i];
    // get String value of intake, succeess
    NSString *intakeVal = [test objectAtIndex:2];
    NSString *successVal = [test objectAtIndex:3];
    currentIntake = [intakeVal intValue];
    currentSuccess = [successVal floatValue];
}

-(void)changeFluidViewLevel: (int) intake{
    switch(intake){
        case 0:
            [fluidview fillTo:@0.02];
            break;
        case 1:
            [fluidview fillTo:@0.1];
            break;
        case 2:
            [fluidview fillTo:@0.2];
            break;
        case 3:
            [fluidview fillTo:@0.3];
            break;
        case 4:
            [fluidview fillTo:@0.4];
            break;
        case 5:
            [fluidview fillTo:@0.5];
            break;
        case 6:
            [fluidview fillTo:@0.6];
            break;
        case 7:
            [fluidview fillTo:@0.7];
            break;
        case 8:
            [fluidview fillTo:@0.8];
            break;
        default:
            [fluidview fillTo:@0.02];
            break;
    }
    [fluidview startAnimation];
}

-(NSString *)getUpdateQueryString{
    return [NSString stringWithFormat:@"update waterIntake set intake='%d', success='%f' where date like '%@'", currentIntake, currentSuccess, [dateFormatter stringFromDate:currentDate]];
}

-(NSString *)getInsertQueryString{
    return [NSString stringWithFormat:@"insert into waterIntake values('%@', '%d', '%d', %f)", [dateFormatter stringFromDate:currentDate], 8, 1, 0.0f];
}

-(void)insertANewRecord{
    
     // Execute the query.
     [self.dbManager executeQuery:query];
     
     // If the query was successfully executed then pop the view controller.
     if (self.dbManager.affectedRows != 0) {
     NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
     
     // Pop the view controller.
     [self.navigationController popViewControllerAnimated:YES];
     }
     else{
     NSLog(@"Could not execute the query.");
     }
    [self loadData];
}

-(void)addIntake{
    currentIntake = currentIntake + 1;
    currentSuccess = (currentIntake/8) * 100;
}

-(void)removeIntake{
    if (currentIntake != 0){
        currentIntake = currentIntake - 1;
        currentSuccess = (currentIntake/8) * 100;
    }
}

@end
