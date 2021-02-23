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

- (nullable NSString *)stubWithURL:(nonnull NSURL *)url;

@end

#endif /* SGNetworkStubsDataSource_h */
