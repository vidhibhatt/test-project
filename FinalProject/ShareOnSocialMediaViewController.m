//
//  ShareOnSocialMediaViewController.m
//  FinalProject
//
//  Created by Vidhi Bhatt on 12/7/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "ShareOnSocialMediaViewController.h"
#import "SWRevealViewController.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Chameleon.h"
#import "JRMFloatingAnimationView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface ShareOnSocialMediaViewController ()

@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;
@end

@implementation ShareOnSocialMediaViewController{
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
    
    NSMutableArray *colors = [NSMutableArray array];
    [colors addObject:FlatWhite];
    [colors addObject:FlatPowderBlue];
    
    _socialMediaView.backgroundColor = GradientColor(UIGradientStyleRadial, _socialMediaView.bounds, colors);
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:[_twitterButton center]];
    [self.floatingView addImage:[UIImage imageNamed:@"bubble"]];
    [self.view addSubview:self.floatingView];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    [self setupFluidView];
}

-(void) setupFluidView{
    fluidview = [[BAFluidView alloc] initWithFrame:self.view.frame];
    fluidview.fillRepeatCount = 1;
    fluidview.fillAutoReverse = NO;
    [fluidview fillTo:@0.02];
    fluidview.fillColor = [UIColor colorWithHex:0x397ebe];
    [fluidview startAnimation];
    [_socialMediaView insertSubview:fluidview atIndex:0];
}

- (void)animate {
    [self.floatingView animate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postToFacebook:(UIButton *)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Test post for facebook-simulator"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)postToTwitter:(UIButton *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Test post from simulator"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
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
