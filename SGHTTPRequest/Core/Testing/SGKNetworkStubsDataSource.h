//
//  SGKNetworkStubsDataSource.h
//  Pods
//
//  Created by Brian Maci on 2/22/21.
//

#ifndef SGKNetworkStubsDataSource_h
#define SGKNetworkStubsDataSource_h

@protocol SGKNetworkStubsDataSource <NSObject>

- (nullable NSString *)stubForURL:(nonnull NSURL *)url;

@end

#endif /* SGKNetworkStubsDataSource_h */
