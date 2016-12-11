//
//  VideoViewController.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "VideoViewController.h"
#import "SWRevealViewController.h"
#import "JRMFloatingAnimationView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Chameleon.h"
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface VideoViewController ()
@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;

@end

@implementation VideoViewController{
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
    
    _benefitsView.backgroundColor = GradientColor(UIGradientStyleRadial, _benefitsView.bounds, colors);

    /*self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:[_seeVideoBtn center]];
    [self.floatingView addImage:[UIImage imageNamed:@"bubble"]];
    [self.view addSubview:self.floatingView];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];*/
    //[self setupFluidView];
}

-(void) setupFluidView{
    fluidview = [[BAFluidView alloc] initWithFrame:self.view.frame];
    fluidview.fillRepeatCount = 1;
    fluidview.fillAutoReverse = NO;
    [fluidview fillTo:@0.05];
    fluidview.fillColor = [UIColor colorWithHex:0x397ebe];
    [fluidview startAnimation];
    [_benefitsView sendSubviewToBack:fluidview];
}
    
- (void)animate {
        [self.floatingView animate];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playPressed:(UIButton *)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:filePath];
    //filePath may be from the Bundle or from the Saved file Directory, it is just the path for the video
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    //[playerViewController.player play];//Used to Play On start
    self.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:playerViewController animated:YES completion:nil];
    
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
