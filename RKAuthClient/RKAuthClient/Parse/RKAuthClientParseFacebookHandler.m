//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParseFacebookHandler.h"

#import <Parse/PFFacebookUtils.h>
#import "PFUser+RKAuthClient.h"

@implementation RKAuthClientParseFacebookHandler

// appId is unused because Parse requires calling `[PFFacebookUtils initializeFacebook];` at start-up
// which will get the appId out of the plist the same way the Facebook SDK does
// `audience` will be used, that is just a TODO
- (void)loginToFacebookWithAppId:(NSString *) __unused appId
                     permissions:(NSArray *)permissions
                        audience:(NSString *) __unused audience
                      completion:(RKAuthClientUserBlock)completionBlock
                   callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (!user) {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(nil, errorResult);
      } else {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(user, errorResult);
      }
    });
  }];
}

- (void)disconnectFromFacebookWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                               callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  PFUser *user = [PFUser currentUser];
  [PFFacebookUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (succeeded) {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      } else {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientFacebookHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      }
    });
  }];
}

@end
