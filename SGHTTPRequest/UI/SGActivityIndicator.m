//
//  SGActivityIndicator.m
//  SeatGeek
//
//  Created by James Van-As on 31/07/13.
//  Copyright (c) 2013 SeatGeek. All rights reserved.
//

#ifdef TARGET_OS_IOS

#import "SGActivityIndicator.h"

@implementation SGActivityIndicator {
    int _activityCount;
    BOOL _indicatorVisible;
}

- (void)incrementActivityCount {
    _activityCount++;
    [self turnOnIndicator];
}

- (void)decrementActivityCount {
    if (_activityCount == 0) {
        return;
    }
    _activityCount--;
    if (_activityCount == 0) {
        [self turnOffIndicatorAfterDelay];
    }
}

- (void)turnOnIndicator {
    if (_indicatorVisible) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnOffIndicator)
          object:nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sharedApplication setNetworkActivityIndicatorVisible:YES];
    });

    _indicatorVisible = YES;
}

- (void)turnOffIndicator {
    if (!_indicatorVisible) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sharedApplication setNetworkActivityIndicatorVisible:NO];
    });
    _indicatorVisible = NO;
}

- (void)turnOffIndicatorAfterDelay {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnOffIndicator)
          object:nil];
    [self performSelector:@selector(turnOffIndicator) withObject:nil afterDelay:0.2];
}

- (UIApplication *)sharedApplication {
    // xcode throws compiler errors if you try use UIApplication.sharedApplication inside the today widget.
    // We also need to make sure we're not in an app extension since the performSelector will still work
    // if we work around the compiler error, but it's still not allowed by Apple.
    if ([NSBundle.mainBundle.bundlePath hasSuffix:@".appex"]) {
        return nil;
    }
    if (![UIApplication respondsToSelector:@selector(sharedApplication)]) {
        return nil;
    }
    return [UIApplication performSelector:@selector(sharedApplication)];
}

@end

#endif
