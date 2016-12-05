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

@interface DashboardViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrWaterInfo;

-(void)loadData;

@end

@implementation DashboardViewController{
    WaterIntakeByDate *todayIntake;
    NSDate *today;
    NSDate *currentDate;
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
    
    todayIntake = [[WaterIntakeByDate alloc] initWithGoal:8 andIntake:0 andProgress:0 andTodayDate: today];
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    [self loadData ];
    
    /*
     // Prepare the query string.
     NSString *query = [NSString stringWithFormat:@"insert into waterIntake values('%@', '%d', '%d', %f)", today, 1, 8, 0.0f];
     
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
     } */
    
    
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
- (IBAction)addPressed:(UIButton *)sender {
    [todayIntake addIntake];
    _intakeLabel.text = [NSString stringWithFormat: @"%d", todayIntake.intake];
    _successLabel.text = [NSString stringWithFormat: @"%f", todayIntake.progress];
}

- (IBAction)removePressed:(UIButton *)sender {
    [todayIntake removeIntake];
    _intakeLabel.text = [NSString stringWithFormat: @"%d", todayIntake.intake];
    _successLabel.text = [NSString stringWithFormat: @"%f", todayIntake.progress];
    
}


- (IBAction)nextDatePressed:(UIButton *)sender {
    [todayIntake nextDatePressed:currentDate];
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    dateString = [formatter stringFromDate:todayIntake.currentDate];
    _currentDateLabel.text = dateString;
    // change current date
    currentDate = todayIntake.currentDate;
    
    
    NSString *query = [NSString stringWithFormat:@"insert into waterIntake values('%@', '%d', '%d', %f)", currentDate, 1, 8, 0.0f];
    
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
    
}

- (IBAction)prevDatePressed:(UIButton *)sender {
    [todayIntake previousDatePressed:currentDate];
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    dateString = [formatter stringFromDate:todayIntake.currentDate];
    _currentDateLabel.text = dateString;
    // change current date
    currentDate = todayIntake.currentDate;
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from waterIntake";
    
    // Get the results.
    if (self.arrWaterInfo != nil) {
        self.arrWaterInfo = nil;
    }
    self.arrWaterInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    //[self.tblPeople reloadData];
}


@end
