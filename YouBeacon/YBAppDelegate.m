//
//  YBAppDelegate.m
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "YBAppDelegate.h"

#import "YBViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface YBAppDelegate ()

@property (nonatomic) YBViewController *viewController;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLBeaconRegion *region;

@end

#pragma mark -

@implementation YBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.viewController = [[YBViewController alloc] initWithNibName:nil bundle:nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self.viewController;

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:uuid.UUIDString];
    [self.locationManager startRangingBeaconsInRegion:self.region];

    return YES;
}
							
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.locationManager startRangingBeaconsInRegion:self.region];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.locationManager stopRangingBeaconsInRegion:self.region];
    [self.viewController resetAnimations];
}

@end