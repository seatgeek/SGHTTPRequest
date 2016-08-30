//
//  SGActivityIndicator.h
//  SeatGeek
//
//  Created by James Van-As on 31/07/13.
//  Copyright (c) 2013 SeatGeek. All rights reserved.
//

#ifdef TARGET_OS_IOS

@interface SGActivityIndicator : NSObject

- (void)incrementActivityCount;
- (void)decrementActivityCount;

@end

#endif
