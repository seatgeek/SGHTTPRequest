//
//  NSString+SGHTTPRequest.m
//  Pods
//
//  Created by James Van-As on 29/06/15.
//
//

#import "NSString+SGHTTPRequest.h"

@implementation NSString (SGHTTPRequest)

#pragma clang diagnostic push
#pragma ide diagnostic ignored "UnavailableInDeploymentTarget"
- (BOOL)containsSubstring:(NSString *)substring {
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:substring];
    }
    return [self rangeOfString:substring].location != NSNotFound;
}
#pragma clang diagnostic pop

@end
