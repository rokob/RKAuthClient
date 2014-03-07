//  Copyright (c) 2014 rokob. All rights reserved.

#include <Foundation/Foundation.h>

@protocol RKUser;
@class ACAccount;

typedef void(^RKAuthClientUserBlock)(id<RKUser> user, NSError *error);
typedef void(^RKAuthClientPasswordChangeBlock)(NSError *error, BOOL success);
typedef void(^RKAuthClientErrorBlock)(NSError *error);

@protocol RKUser <NSObject>

- (NSString *)token;
- (NSString *)userId;
- (NSString *)email;

- (BOOL)isNew;
- (ACAccount *)thirdPartyUserAccount;
- (NSDictionary *)thirdPartyUserData;

@end

extern NSString *kRKAuthClientErrorDomain;

typedef NS_ENUM(NSInteger, RKAuthClientBasicHandlerError) {
  RKAuthClientBasicHandlerErrorUnimplemented = 0,
};

typedef NS_ENUM(NSInteger, RKAuthClientEmailHandlerError) {
  RKAuthClientEmailHandlerErrorUnimplemented = 0,
  RKAuthClientEmailHandlerErrorMissingInput = 1,
};

typedef NS_ENUM(NSInteger, RKAuthClientFacebookHandlerError) {
  RKAuthClientFacebookHandlerErrorUnimplemented = 0,
  RKAuthClientFacebookHandlerErrorMissingAppId = 1,
};

typedef NS_ENUM(NSInteger, RKAuthClientTwitterHandlerError) {
  RKAuthClientTwitterHandlerErrorUnimplemented = 0,
  RKAuthClientTwitterHandlerErrorMissingAppId = 1,
};