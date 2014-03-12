//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParseTwitterHandler.h"

#import <Parse/PFTwitterUtils.h>
#import "PFUser+RKAuthClient.h"

@implementation RKAuthClientParseTwitterHandler

- (void)loginToTwitterWithAppId:(NSString *)appId
        multipleAccountsHandler:(int (^)(NSArray *))accountSelection
                     completion:(RKAuthClientUserBlock)completionBlock
                  callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (!user) {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(nil, errorResult);
      } else {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(user, errorResult);
      }
    });
  }];
}

- (void)disconnectFromTwitterWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                              callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  PFUser *user = [PFUser currentUser];
  [PFTwitterUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (succeeded) {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      } else {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientTwitterHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      }
    });
  }];
}

@end
