//
//  SGHTTPRequestTests.m
//  SGHTTPRequest
//
//  Created by James Van-As on 4/02/16.
//  Copyright © 2016 James Van-As. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SGHTTPRequest/SGHTTPRequest.h>
#import "SGTestHelpers.h"


@interface SGHTTPRequestTests : XCTestCase
@end

@implementation SGHTTPRequestTests

- (void)testJSONValidGetRequest {
    [SGHTTPRequest clearCache];

    XCTestExpectation *expectation = [self expectationWithDescription:@"testJSONValidGetRequest completed"];

    SGHTTPRequest *request = self.jsonGetRequest;
    request.onSuccess = ^(SGHTTPRequest *req) {
        XCTAssertNotNil(req.responseJSON[@"meta"], @"Correctly formatted json GET request should contain valid JSON in the response.");
        [expectation fulfill];
    };
    request.onFailure = ^(SGHTTPRequest *req) {
        XCTAssert(NO, @"Correctly formatted json GET request should not fail.");
        [expectation fulfill];
    };
    [request start];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Expectation Timeout Error: %@", error);
        }
    }];
}

- (void)testJSONInvalidGetRequest {
    [SGHTTPRequest clearCache];

    XCTestExpectation *expectation = [self expectationWithDescription:@"testJSONInvalidGetRequest completed"];

    SGHTTPRequest *request = [SGHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com/thisdoesnotexist"]];
    request.onSuccess = ^(SGHTTPRequest *req) {
        XCTAssert(NO, @"GET request for invalid URL should not succeed.");
        [expectation fulfill];
    };
    request.onFailure = ^(SGHTTPRequest *req) {
        XCTAssert(req.statusCode == 404, @"HTTP Get for url that does not exist should 404");
        [expectation fulfill];
    };
    [request start];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Expectation Timeout Error: %@", error);
        }
    }];
}

- (void)testETagJSONGetRequest {
    [SGHTTPRequest clearCache];

    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];

    SGHTTPRequest.allowCacheToDisk = YES;

    XCTestExpectation *expectation = [self expectationWithDescription:@"testETagJSONGetRequest completed"];

    __block void (^onFirstRequestComplete)() = ^{
        SGHTTPRequest *secondRequest = self.jsonGetRequest;
        secondRequest.onSuccess = ^(SGHTTPRequest *req) {
            XCTAssertNotNil(req.responseJSON[@"meta"], @"Second request using ETag caching should return cached version");

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDictionary *cachedJSON = req.cachedResponseJSON;
                XCTAssertNotNil(cachedJSON[@"meta"], @"Second request using ETag caching should contain a cached version");

                [expectation fulfill];
            });
        };
        secondRequest.onFailure = ^(SGHTTPRequest *req) {
            XCTAssert(NO, @"Correctly formatted json GET request should not fail.");
            [expectation fulfill];
        };
        [secondRequest start];
    };

    SGHTTPRequest *request = self.jsonGetRequest;
    request.onSuccess = ^(SGHTTPRequest *req) {
        onFirstRequestComplete();
    };
    request.onFailure = ^(SGHTTPRequest *req) {
        XCTAssert(NO, @"Correctly formatted json GET request should not fail.");
        onFirstRequestComplete();
    };
    [request start];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Expectation Timeout Error: %@", error);
        }
    }];
}

- (void)testETagJSONFullCache {
    SGHTTPRequest.logging = SGHTTPLogCache;

    SGFileCache *cache;

    if ([SGHTTPRequest.class respondsToSelector:@selector(cache)]) {
        cache = [SGHTTPRequest.class performSelector:@selector(cache)];
    }
    NSAssert(cache, @"Could not access the SGHTTPRequest cache singleton");

    [SGTestHelpers fillCache:cache startExpiryDate:[NSDate.date dateByAddingTimeInterval:30]];

    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];

    SGHTTPRequest.allowCacheToDisk = YES;

    XCTestExpectation *expectation = [self expectationWithDescription:@"testETagJSONGetRequest completed"];

    __block void (^onFirstRequestComplete)() = ^{
        SGHTTPRequest *secondRequest = self.jsonGetRequest;
        secondRequest.onSuccess = ^(SGHTTPRequest *req) {
            XCTAssertNotNil(req.responseJSON[@"meta"], @"Second request using ETag caching should return cached version");

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDictionary *cachedJSON = req.cachedResponseJSON;
                XCTAssertNotNil(cachedJSON[@"meta"], @"Second request using ETag caching should contain a cached version");

                [expectation fulfill];
            });
        };
        secondRequest.onFailure = ^(SGHTTPRequest *req) {
            XCTAssert(NO, @"Correctly formatted json GET request should not fail.");
            [expectation fulfill];
        };
        [secondRequest start];
    };

    SGHTTPRequest *request = self.jsonGetRequest;
    request.onSuccess = ^(SGHTTPRequest *req) {
        onFirstRequestComplete();
    };
    request.onFailure = ^(SGHTTPRequest *req) {
        XCTAssert(NO, @"Correctly formatted json GET request should not fail.");
        onFirstRequestComplete();
    };
    [request start];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Expectation Timeout Error: %@", error);
        }
    }];
}

#pragma mark Test Requests

- (SGHTTPRequest *)jsonGetRequest {
    return [SGHTTPRequest requestWithURL:[NSURL URLWithString:@"http://api.seatgeek.com/2/events?venue.state=NY"]];
}

@end
