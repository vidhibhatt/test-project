//
//  LoginViewController.m
//  FinalProject
//
//  Created by Vidhi Bhatt on 12/11/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alert:(NSString*)message
       title:(NSString*) title {
    // Show some greeting message
    // Creating a simple alert
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    // Creating the actions of the alert
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   //NSLog(@"This is working");
                                   [self  performSegueWithIdentifier:@"afterLoginSegue" sender:self];
                               }];
    
    [alert addAction:okButton];
    
    // Showing the alert
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)registerClicked:(UIButton *)sender {
    //This gets the fields from the UITextFields
    NSString* username = [_userNameTextField text];
    NSString* password = [_passwordTextField text];
    
    //We are not setting the email here; just for simplicity sake
    PFUser* user = [PFUser user];
    user.username = username;
    user.password = password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error) {
            [self alert:@"Registered successfully!" title:@"Register"];
            
        }
        else {
            NSString* errorString = [error userInfo][@"error"];
            [self alert:errorString title:@"Error"];
        }
    }];
    
}

- (IBAction)loginClicked:(UIButton *)sender {
    
    //This gets the fields from the UITextFields
    NSString* username = [_userNameTextField text];
    NSString* password = [_passwordTextField text];
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self alert:@"Welcome back" title:@"Login"];
                        
                                        } else {
                                            NSString* errorString = [error userInfo][@"error"];
                                            [self alert:errorString title:@"Error"];
                                        }
                                    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"segueFromLogin"]){
        //UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        SWRevealViewController *controller = (SWRevealViewController *)[segue destinationViewController];
        [self presentViewController:controller animated:true completion:nil];
        //controller.dbManager = self.dbManager;
        //controller.arrWaterInfo = self.arrWaterInfo;
       // controller.existingDateKeysInDB = existingDateKeysInDB;
        //controller.dateAndIndex = dateAndIndex;
    }
    
}

*/
@end
