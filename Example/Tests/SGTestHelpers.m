//
//  SGTestHelpers.m
//  SGHTTPRequest
//
//  Created by James Van-As on 4/02/16.
//  Copyright © 2016 James Van-As. All rights reserved.
//

#import "SGTestHelpers.h"
#import "SGFileCache.h"

@interface SGTestHelpers ()
@end

@implementation SGTestHelpers

+ (void)fillCache:(SGFileCache *)cache startExpiryDate:(NSDate *)startExpiryDate {
    NSInteger maxCacheSize = cache.maxDiskCacheSizeMB ? cache.maxDiskCacheSizeMB * 1000000 : 1000000;

    NSDate *expiryDate = startExpiryDate.copy;

    NSUInteger itemSize = 200000;
    NSUInteger itemsRequired = (maxCacheSize / itemSize);
    NSUInteger keyIncrementer = 0;

    while (itemsRequired--) {
        NSString *key = [NSString stringWithFormat:@"pk%@", @(keyIncrementer)];
        NSData* testData = [[self randomStringOfLength:itemSize] dataUsingEncoding:NSUTF8StringEncoding];
        [cache cacheData:testData for:key expiryDate:expiryDate];
        keyIncrementer++;
        expiryDate = [expiryDate dateByAddingTimeInterval:1];
    }
}

+ (void)fillCacheNamed:(NSString *)named startExpiryDate:(NSDate *)startExpiryDate {
    SGFileCache *cache = [SGFileCache cacheFor:named];
    [self fillCache:cache startExpiryDate:startExpiryDate];
}

+ (NSDictionary *)testDataDict {
    static NSDictionary *json;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *filePath = [bundle pathForResource:@"TestJSON" ofType:@"json"];
        NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSAssert(json, @"Failed to read test json file");
    });
    return json;
}

+ (NSString *)randomStringOfLength:(NSUInteger)length {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i=0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % letters.length]];
    }
    return randomString;
}

@end
