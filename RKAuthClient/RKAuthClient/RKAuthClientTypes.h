//  Copyright (c) 2014 rokob. All rights reserved.

@protocol RKUser;

typedef void(^RKAuthClientUserBlock)(id<RKUser> user, NSError *error);
typedef void(^RKAuthClientPasswordChangeBlock)(NSError *error, BOOL success);
typedef void(^RKAuthClientErrorBlock)(NSError *error);

@protocol RKUser <NSObject>

- (NSString *)userId;

@end
