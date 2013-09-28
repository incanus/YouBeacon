//
//  YBAppDelegate.m
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "YBAppDelegate.h"

#import "YBViewController.h"

@implementation YBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[YBViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

@end