//
//  YBViewController.h
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface YBViewController : UIViewController <CLLocationManagerDelegate>

- (void)resetAnimations;

@end