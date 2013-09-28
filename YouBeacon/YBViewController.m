//
//  YBViewController.m
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "YBViewController.h"

#import <CoreLocation/CoreLocation.h>

// registration table, in the food room, the quiet room, and toward the front of the main presentation area

@interface YBViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;

@end

#pragma mark -

@implementation YBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];

        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
        [self.locationManager startRangingBeaconsInRegion:[[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:uuid.UUIDString]];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2c.png"]];
    logo.center = self.view.center;
    [self.view addSubview:logo];
}

#pragma mark -

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"=====");

    for (CLBeacon *beacon in beacons)
    {
        if (beacon.proximity != CLProximityUnknown)
        {
            NSString *proximityString;

            if (beacon.proximity == CLProximityFar)
                proximityString = @"Far";
            else if (beacon.proximity == CLProximityNear)
                proximityString = @"Near";
            else if (beacon.proximity == CLProximityImmediate)
                proximityString = @"Immediate";

            NSLog(@"%@,%@: %@", beacon.major, beacon.minor, proximityString);
        }
    }
}

@end