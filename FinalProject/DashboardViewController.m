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

@interface DashboardViewController ()

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


@end
