//
//  DashboardViewController.h
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;

@property (weak, nonatomic) IBOutlet UILabel *intakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@end
