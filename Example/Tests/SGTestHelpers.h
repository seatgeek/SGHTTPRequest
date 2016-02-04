//
//  SGTestHelpers.h
//  SGHTTPRequest
//
//  Created by James Van-As on 4/02/16.
//  Copyright © 2016 James Van-As. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGFileCache;

@interface SGTestHelpers : NSObject

+ (void)fillCache:(SGFileCache *)cache startExpiryDate:(NSDate *)startExpiryDate;
+ (void)fillCacheNamed:(NSString *)named startExpiryDate:(NSDate *)startExpiryDate;
+ (NSDictionary *)testDataDict;

@end
