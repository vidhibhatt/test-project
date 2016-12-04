//
//  AcknowledgementsViewController.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "AcknowledgementsViewController.h"
#import "SWRevealViewController.h"

@interface AcknowledgementsViewController ()

@end

@implementation AcknowledgementsViewController{
    // Links
    NSString *hamburger;
    NSString *video;

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
}

// method to initialize strings for links
-(void)initStrings{
    // Overall app
    hamburger = @"https://github.com/John-Lluch/SWRevealViewController";
    
    // Video
    
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
