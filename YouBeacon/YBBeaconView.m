//
//  YBBeaconView.m
//  YouBeacon
//
//  Created by Justin R. Miller on 9/28/13.
//  Copyright (c) 2013 MapBox. All rights reserved.
//

#import "YBBeaconView.h"

@interface YBBeaconView ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation YBBeaconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor];
        self.layer.borderWidth = 2;

        [self setDuration:0];
    }

    return self;
}

- (void)setBeaconID:(NSNumber *)beaconID
{
    _beaconID = beaconID;

    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _beaconID]]];
    imageView.bounds = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [self addSubview:imageView];
}

- (void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;

    if (_duration == 0)
    {
        self.transform = CGAffineTransformIdentity;
    }
    else
    {
        [UIView animateWithDuration:_duration
                              delay:0
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState
                         animations:^(void)
                         {
                             self.transform = CGAffineTransformMakeScale(0.95, 0.95);
                         }
                         completion:nil];
    }

}

@end