//
//  AcknowledgementsViewController.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "AcknowledgementsViewController.h"
#import "SWRevealViewController.h"
#import "Chameleon.h"
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface AcknowledgementsViewController ()

@end

@implementation AcknowledgementsViewController{
    // Links
    NSString *hamburger;
    NSString *video;
    NSString *socialMedia;
    BAFluidView *fluidview;

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
    [self initStrings];
    
    NSMutableArray *colors = [NSMutableArray array];
    [colors addObject:FlatWhite];
    [colors addObject:FlatPowderBlue];
    
    _ackView.backgroundColor = GradientColor(UIGradientStyleRadial, _ackView.bounds, colors);
    [self setupFluidView];
}

-(void) setupFluidView{
    fluidview = [[BAFluidView alloc] initWithFrame:self.view.frame];
    fluidview.fillRepeatCount = 1;
    fluidview.fillAutoReverse = NO;
    [fluidview fillTo:@0.02];
    fluidview.fillColor = [UIColor colorWithHex:0x397ebe];
    [fluidview startAnimation];
    [_ackView insertSubview:fluidview atIndex:0];
}

// method to initialize strings for links
-(void)initStrings{
    // Overall app
    hamburger = @"https://github.com/John-Lluch/SWRevealViewController";
    
    // Video
    
    // social media
    socialMedia = @"http://www.appcoda.com/ios-programming-101-integrate-twitter-and-facebook-sharing-in-ios-6/";
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

@end
