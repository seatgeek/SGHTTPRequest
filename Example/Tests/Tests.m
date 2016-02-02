//
//  SGFileCacheTest.m
//  Pods
//
//  Created by James Van-As on 2/02/16.
//
//

#import <XCTest/XCTest.h>
#import "SGFileCache.h"

#define SGTestCacheName @"SGTestCache"

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

    XCTAssert([SGFileCache cacheFor:SGTestCacheName].cacheFolder.length, @"Named cache should be returned");
    XCTAssert([SGFileCache cacheFor:SGTestCacheName].cacheFolder.length, @"Named cache folder should be have a length");

    XCTAssertNotEqual([SGFileCache cacheFor:nil].cacheFolder,
                      [SGFileCache cacheFor:SGTestCacheName].cacheFolder, @"Different caches should have different cache folders");

    [self runTestsForCache:nil];
    [self runTestsForCache:SGTestCacheName];
}

- (void)runTestsForCache:(NSString *)cacheName {
    XCTAssertNil([[SGFileCache cacheFor:cacheName] secondaryKeyValueNamed:nil forPrimaryKey:nil], @"Nil primary and secondary keys should return nil secondary key value");
    XCTAssertNil([[SGFileCache cacheFor:cacheName] secondaryKeyValueNamed:nil forPrimaryKey:@"test_pk"], @"Nil secondary key should return nil secondary key value");
    XCTAssertNil([[SGFileCache cacheFor:cacheName] secondaryKeyValueNamed:@"test_sk" forPrimaryKey:nil], @"Nil primary key should return nil secondary key value");

}

- (void)testPerformance {
  // TODO: some cache performance tests
  // This is an example of a performance test case.
  [self measureBlock:^{
      // Put the code you want to measure the time of here.
  }];
}

@end
