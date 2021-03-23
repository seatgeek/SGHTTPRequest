//
//  SGNetworkStubsDataSource.h
//  Pods
//
//  Created by Brian Maci on 2/23/21.
//

#ifndef SGNetworkStubsDataSource_h
#define SGNetworkStubsDataSource_h

#pragma mark DataSource protocol to supply network stubs for testing
@protocol SGNetworkStubsDataSource

// Using id here to keep the expected responseObject ready to propagate through success/failure blocks
- (nullable id)stubForURL:(nonnull NSURL *)url parameters:(nullable NSObject *)parameters;

@end

#endif /* SGNetworkStubsDataSource_h */
