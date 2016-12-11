//
//  AlertsViewController.h
//  FinalProject
//
//  Created by Vidhi Bhatt on 12/7/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertsViewController;

@protocol AlertsViewControllerDelegate <NSObject, UIPickerViewDataSource, UIPickerViewDelegate>

@end
@interface AlertsViewController : UIViewController

@property (nonatomic, weak) id <AlertsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (weak, nonatomic) IBOutlet UISwitch *reminderSetting;

@property (weak, nonatomic) IBOutlet UITextField *testTextField;

@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UITextField *everyTextField;
@property (strong, nonatomic) IBOutlet UIView *alertsView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

-(void)createLocalNotification;

@end
