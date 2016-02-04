//
//  SGFileCacheTest.m
//  Pods
//
//  Created by James Van-As on 2/02/16.
//
//

#import <XCTest/XCTest.h>
#import "SGFileCache.h"
#import "SGTestHelpers.h"

#define SGCacheNames @[@"SGTestCache", @"SGTestCache2", @"Illegal:/.,123{}!@#$%^&*()"]
#define SGMultiTestCaches(tests) \
            { \
                NSString *testCache = nil; \
                { tests } \
                for (testCache in SGCacheNames) { \
                    { tests } \
            }   }

// Some private file cache properties we want to test
@interface SGFileCache ()
@property (nonatomic, strong) NSString *cacheFolder;
@end

@interface SGFileCacheTests : XCTestCase

@end

@implementation SGFileCacheTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSingletons {
    XCTAssert([SGFileCache cacheFor:nil], @"Default file should be returned");
    XCTAssert([SGFileCache cacheFor:nil].cacheFolder.length, @"Default cache folder should have a length");

    SGMultiTestCaches(
                      XCTAssert([SGFileCache cacheFor:testCache].cacheFolder.length, @"Named cache should be returned for cache named %@", testCache);
                      XCTAssert([SGFileCache cacheFor:testCache].cacheFolder.length, @"Named cache folder should be have a length for cache named %@", testCache);
                      );

    NSString *cacheName1 = SGCacheNames.firstObject;
    NSString *cacheName2 = SGCacheNames.lastObject;
    XCTAssertNotEqual([SGFileCache cacheFor:nil].cacheFolder,
                      [SGFileCache cacheFor:cacheName1].cacheFolder, @"Different caches should have different cache folders for nil and %@", cacheName1);
    XCTAssertNotEqual([SGFileCache cacheFor:cacheName1].cacheFolder,
                      [SGFileCache cacheFor:cacheName2].cacheFolder, @"Different caches should have different cache folders for %@ and %@", cacheName1, cacheName2);
}

- (void)testKeys {
    SGMultiTestCaches(
                 XCTAssertNil([[SGFileCache cacheFor:testCache] secondaryKeyValueNamed:nil forPrimaryKey:nil],
                              @"Nil primary and secondary keys should return nil secondary key value for cache named %@", testCache);
                 XCTAssertNil([[SGFileCache cacheFor:testCache] secondaryKeyValueNamed:nil forPrimaryKey:@"test_pk"],
                              @"Nil secondary key should return nil secondary key value for cache named %@", testCache);
                 XCTAssertNil([[SGFileCache cacheFor:testCache] secondaryKeyValueNamed:@"test_sk" forPrimaryKey:nil],
                              @"Nil primary key should return nil secondary key value for cache named %@", testCache);
                 );
}

- (void)testFullCache {
    SGMultiTestCaches(

    SGFileCache *cache = [SGFileCache cacheFor:testCache];
    cache.logCache = YES;
    [cache clearCache];

    [SGTestHelpers fillCache:cache startExpiryDate:[NSDate.date dateByAddingTimeInterval:30]];

    NSDictionary *testDict = SGTestHelpers.testDataDict;
    NSData *testData = [NSKeyedArchiver archivedDataWithRootObject:testDict];

    [cache cacheData:testData for:@"testPK"];

    XCTestExpectation *expectation = [self expectationWithDescription:@"testFullCache completed"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *dataFromCache = [cache cachedDataFor:@"testPK"];
        NSDictionary *dictFromCache = [NSKeyedUnarchiver unarchiveObjectWithData:dataFromCache];

        XCTAssert([dictFromCache isEqualToDictionary:testDict], @"Data put in and out of the cache should be equal");

        [cache clearCache]; // clean up
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Expectation Timeout Error: %@", error);
        }}];
    );  // end multi cache test
}

- (void)testWriting {

}

- (void)testSyncReading {

}

- (void)testAsyncReading {

}

- (void)testPerformance {
  // TODO: some cache performance tests
  // This is an example of a performance test case.
  [self measureBlock:^{
      // Put the code you want to measure the time of here.
  }];
}

@end
