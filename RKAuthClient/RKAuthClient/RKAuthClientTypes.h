//  Copyright (c) 2014 rokob. All rights reserved.

#include <Foundation/Foundation.h>

@protocol RKUser;
@class ACAccount;

typedef void(^RKAuthClientUserBlock)(id<RKUser> user, NSError *error);
typedef void(^RKAuthClientSuccessBlock)(NSError *error, BOOL success);

@protocol RKUser <NSObject>

- (NSString *)token;
- (NSString *)userId;
- (NSString *)email;

- (BOOL)isNew;
- (ACAccount *)thirdPartyUserAccount;
- (NSDictionary *)thirdPartyUserData;

@end

extern NSString *kRKAuthClientErrorDomain;
extern NSString *kRKAuthClientServiceErrorKey;

typedef NS_ENUM(NSInteger, RKAuthClientBasicHandlerError) {
  RKAuthClientBasicHandlerErrorUnimplemented = 0,
  RKAuthClientBasicHandlerErrorNoUser = 1,
};

typedef NS_ENUM(NSInteger, RKAuthClientEmailHandlerError) {
  RKAuthClientEmailHandlerErrorUnimplemented = 0,
  RKAuthClientEmailHandlerErrorMissingInput = 1,
  RKAuthClientEmailHandlerErrorServiceError = 2,
  RKAuthClientEmailHandlerErrorNotPossible = 3,
  RKAuthClientEmailHandlerErrorUnknown = 4,
};

typedef NS_ENUM(NSInteger, RKAuthClientFacebookHandlerError) {
  RKAuthClientFacebookHandlerErrorUnimplemented = 0,
  RKAuthClientFacebookHandlerErrorMissingAppId = 1,
  RKAuthClientFacebookHandlerErrorServiceError = 2,
  RKAuthClientFacebookHandlerErrorNotPossible = 3,
  RKAuthClientFacebookHandlerErrorUnknown = 4,
};

typedef NS_ENUM(NSInteger, RKAuthClientTwitterHandlerError) {
  RKAuthClientTwitterHandlerErrorUnimplemented = 0,
  RKAuthClientTwitterHandlerErrorMissingAppId = 1,
  RKAuthClientTwitterHandlerErrorServiceError = 2,
  RKAuthClientTwitterHandlerErrorNotPossible = 3,
  RKAuthClientTwitterHandlerErrorUnknown = 4,
};