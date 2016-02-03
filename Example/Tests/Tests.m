//
//  SGFileCacheTest.m
//  Pods
//
//  Created by James Van-As on 2/02/16.
//
//

#import <XCTest/XCTest.h>
#import "SGFileCache.h"

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

@interface SGFileCacheTest : XCTestCase

@end

@implementation SGFileCacheTest

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


#pragma mark Convenience getters

- (NSDictionary *)dataDictionary {

}

- (NSDictionary *)bigDataDictionary {

}

- (NSString *)dataString {

}

- (NSString *)bigDataString {

}

@end
