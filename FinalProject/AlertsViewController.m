//
//  AlertsViewController.m
//  FinalProject
//
//  Created by Vidhi Bhatt on 12/7/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "AlertsViewController.h"
#import "DownPicker.h"
#import "Chameleon.h"
#import "JRMFloatingAnimationView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SWRevealViewController.h"
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface AlertsViewController (){
    NSUserDefaults *defaults;//this will keep track as to whether the notification is on or off
    NSUInteger indexOfFrom, indexOfTo, indexOfEvery;
    BAFluidView *fluidview;
    
}
@property (strong, nonatomic) NSArray* fromArray;
@property (strong, nonatomic) NSArray* toArray;
@property (strong, nonatomic) NSArray* everyArray;
@property NSString *stringToReturn;
@property NSMutableString *toSelected;
@property NSMutableString *fromSelected;
@property NSMutableString *everySelected;
@property  (strong, nonatomic) DownPicker *fromDownPicker;
@property  (strong, nonatomic) DownPicker *toDownPicker;
@property  (strong, nonatomic) DownPicker *everyDownPicker;
@property  NSUserDefaults *defaults;//this will keep track as to whether the notification is on or off


@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;


@end

@implementation AlertsViewController


-(void)loadView{
    [super loadView];
    [self setupFluidView];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [_barButton setTarget: self.revealViewController];
        [_barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    // Do any additional setup after loading the view.
    self.fromArray = @[@"8am", @"9am", @"10am", @"11am", @"12pm", @"1pm", @"2pm", @"3pm", @"4pm", @"5pm", @"6pm", @"7pm", @"8pm", @"9pm", @"10pm"];
    
     self.toArray = @[@"8am", @"9am", @"10am", @"11am", @"12pm", @"1pm", @"2pm", @"3pm", @"4pm", @"5pm", @"6pm", @"7pm", @"8pm", @"9pm", @"10pm"];
    
    self.everyArray = @[@"1 hr", @"2 hr", @"3 hr", @"4 hr", @"5 hr"];
    
    self.stringToReturn = [[NSString alloc]init];
    self.fromSelected = [[NSMutableString alloc]init];
    self.toSelected = [[NSMutableString alloc]init];
    self.everySelected = [[NSMutableString alloc]init];
    // Connect data
    
    self.fromDownPicker = [[DownPicker alloc] initWithTextField:self.testTextField withData:self.fromArray];
    [self.fromDownPicker addTarget:self action:@selector(from_selected:) forControlEvents:UIControlEventValueChanged];
    
    self.toDownPicker = [[DownPicker alloc] initWithTextField:self.toTextField withData:self.toArray];
    [self.toDownPicker addTarget:self action:@selector(to_selected:) forControlEvents:UIControlEventValueChanged];
    
    self.everyDownPicker = [[DownPicker alloc] initWithTextField:self.everyTextField withData:self.everyArray];
    [self.everyDownPicker addTarget:self action:@selector(every_selected:) forControlEvents:UIControlEventValueChanged];
    
    NSMutableArray *colors = [NSMutableArray array];
    [colors addObject:FlatWhite];
    [colors addObject:FlatPowderBlue];
    
    _alertsView.backgroundColor = GradientColor(UIGradientStyleRadial, _alertsView.bounds, colors);
    
    self.defaults = [NSUserDefaults standardUserDefaults];UIUserNotificationType types = UIUserNotificationTypeBadge| UIUserNotificationTypeSound| UIUserNotificationTypeAlert; UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:[_saveBtn center]];
    [self.floatingView addImage:[UIImage imageNamed:@"bubble"]];
    [self.view addSubview:self.floatingView];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    
}


-(void) setupFluidView{
    fluidview = [[BAFluidView alloc] initWithFrame:self.view.frame];
    fluidview.userInteractionEnabled = YES;
    fluidview.clipsToBounds = YES;
    fluidview.fillRepeatCount = 1;
    fluidview.fillAutoReverse = NO;
    [fluidview fillTo:@0.02];
    fluidview.fillColor = [UIColor colorWithHex:0x397ebe];
    [fluidview startAnimation];
    //fluidview.alpha = 0.1;
    //[self.view insertSubview:fluidview aboveSubview:self.view];
    [_alertsView insertSubview:fluidview atIndex:0];
    //[_alertsView addSubview:fluidview];
}

- (void)animate {
    [self.floatingView animate];
}



-(void)from_selected:(id)dp{
    self.fromSelected = [self.fromDownPicker text];
    
}

-(void)to_selected:(id)dp{
    self.toSelected = [self.toDownPicker text];
}

-(void)every_selected:(id)dp{
    self.everySelected = [self.everyDownPicker text];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) createLocalNotification{
    // Schedule the notification
    
    [self.defaults setBool:YES forKey:@"notificationIsActive"];
    [self.defaults synchronize];
    //self.message.text=@"Notifications Started";
    //while([self.defaults integerForKey: @"fromIntHour"] <= [NSDate date]){
    NSTimeInterval interval;
    interval = 60;
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:interval]; //Enter the time here in seconds.
    localNotification.alertBody= @"Remember to drink a glass of water!";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval= NSCalendarUnitDay;//NSCalendarUnitMinute; //Repeating instructions here.
    localNotification.soundName= UILocalNotificationDefaultSoundName; [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    /*[self.defaults setBool:YES forKey:@"notificationIsActive"];
     [self.defaults synchronize];
     NSTimeInterval interval;
     interval = 60;
     UILocalNotification* localNotification = [[UILocalNotification alloc] init];localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:interval]; //Enter the time here in seconds.
     localNotification.alertBody= @"Remember to drink a glass of water!";
     localNotification.timeZone = [NSTimeZone defaultTimeZone];
     localNotification.repeatInterval= NSCalendarUnitDay;//NSCalendarUnitMinute; //Repeating instructions here.
     localNotification.soundName= UILocalNotificationDefaultSoundName; [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];*/
    
}

- (void) getPickerDate{

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveClicked:(UIButton *)sender {
    if([self.reminderSetting isOn]){
        [self createLocalNotification];
    }
    
    indexOfFrom = [self.fromArray indexOfObject:self.fromSelected];
    indexOfTo = [self.toArray indexOfObject:self.toSelected];
    indexOfEvery = [self.everyArray indexOfObject:self.everySelected];
    
    [self.defaults setInteger:[self returnHour:indexOfFrom] forKey:@"fromIntHour"];
    [self.defaults setInteger:[self returnHour:indexOfTo] forKey:@"toIntHour"];
    [self.defaults setInteger:[self returnEveryHour:indexOfEvery] forKey:@"everyIntHour"];
    
}

- (NSInteger)returnHour:(NSUInteger)index{
    switch (index) {
        case 0:
            return 8;
            break;
        case 1:
            return 9;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 11;
            break;
        case 4:
            return 12;
            break;
        case 5:
            return 13;
            break;
        case 6:
            return 14;
            break;
        case 7:
            return 15;
            break;
        case 8:
            return 16;
            break;
        case 9:
            return 17;
            break;
        case 10:
            return 18;
            break;
        case 11:
            return 19;
            break;
        case 12:
            return 20;
            break;
        case 13:
            return 21;
            break;
        case 14:
            return 22;
            break;
            
        default:
            return 0;
            break;
    }
}


- (NSInteger)returnEveryHour:(NSUInteger)index{
    switch (index) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 4;
            break;
        case 4:
            return 5;
            break;
        default:
            return 0;
            break;
    }
}


@end
