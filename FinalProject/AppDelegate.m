//
//  AppDelegate.m
//  FinalProject
//
//  Created by Vidhi Harikrishna Bhatt on 12/4/16.
//  Copyright © 2016 Vidhi Harikrishna Bhatt. All rights reserved.
//

#import "AppDelegate.h"
#import "DBManager.h"
#import "Chameleon.h"
#import "SCLAlertView.h"
#import <Parse/Parse.h>

@interface AppDelegate ()
@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Initialize the dbManager object.
    //self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    // Override point for customization after application launch.
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"vLViN7GEenHLi6DQaQbj4zELcIYMcrFewBKIohaP";
        configuration.clientKey = @"fORrj2XuJYyDI38NgHragjjSjNoYaWlDUBLmB32a";
        configuration.server = @"https://parseapi.back4app.com";
        configuration.localDatastoreEnabled = YES; // If you need to enable local data store
    }]];
    return YES;
    
    
    //Set global theme
    //[Chameleon setGlobalThemeUsingPrimaryColor:FlatSkyBlue withSecondaryColor:FlatTeal andContentStyle:UIContentStyleContrast];
    
    
    //return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
       /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];*/
        
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showInfo:@"Reminder" subTitle:@"Just a reminder to drink a glass of water" closeButtonTitle:@"Done" duration:0.0f];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
