//
//  YBViewController.m
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "YBViewController.h"

#import "YBBeaconView.h"

#import <CoreLocation/CoreLocation.h>

#define kYBIDs   @[ @1, @3, @5, @7 ]

@interface YBViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;

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
    logo.alpha = 0.25;
    logo.center = self.view.center;
    [self.view addSubview:logo];

    NSInteger index = 0;

    for (NSInteger row = 0; row < 2; row++)
    {
        for (NSInteger col = 0; col < 2; col++)
        {
            YBBeaconView *beaconView = [[YBBeaconView alloc] initWithFrame:CGRectMake(col * self.view.bounds.size.width  / 2,
                                                                                      row * self.view.bounds.size.height / 2,
                                                                                      self.view.bounds.size.width  / 2,
                                                                                      self.view.bounds.size.height / 2)];

            beaconView.beaconID   = kYBIDs[index];
            [self.view addSubview:beaconView];
            index++;
        }
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for (CLBeacon *beacon in beacons)
    {
        YBBeaconView *beaconView;
        NSString *proximityString;

        if (beacon.proximity != CLProximityUnknown)
        {
            for (beaconView in self.view.subviews)
                if ([beaconView isKindOfClass:[YBBeaconView class]] && [beaconView.beaconID isEqual:beacon.minor])
                    break;

            if (beacon.proximity == CLProximityFar)
            {
                proximityString = @"Far";
                beaconView.duration = 0;
            }
            else if (beacon.proximity == CLProximityNear)
            {
                proximityString = @"Near";
                beaconView.duration = 0.5;
            }
            else if (beacon.proximity == CLProximityImmediate)
            {
                proximityString = @"Immediate";
                beaconView.duration = 0.01;
            }
        }

        if (beaconView)
            NSLog(@"%@,%@: %@", beacon.major, beacon.minor, proximityString);
    }
}

@end