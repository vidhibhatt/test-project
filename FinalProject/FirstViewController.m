//
//  FirstViewController.m
//  FinalProject
//
//  Created by Vidhi Bhatt on 12/5/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "FirstViewController.h"
#import "BAFluidView.h"
#import "UIColor+ColorWithHex.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BAFluidView *view = [[BAFluidView alloc] initWithFrame:self.view.frame];
    [view fillTo:@0.5];
    view.fillColor = [UIColor colorWithHex:0x397ebe];
    [view startAnimation];
    [self.view addSubview:view];
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
