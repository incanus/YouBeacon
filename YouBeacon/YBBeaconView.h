//
//  YBBeaconView.h
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBBeaconView : UIView

@property (nonatomic) NSNumber *beaconID;
@property (nonatomic) NSTimeInterval duration;

@end