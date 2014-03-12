//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParseEmailHandler.h"

#import "PFUser+RKAuthClient.h"

@implementation RKAuthClientParseEmailHandler

- (void)createUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientUserBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  } else if (!email || !password) {
    dispatch_async(callbackQueue, ^{
      NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                           code:RKAuthClientEmailHandlerErrorMissingInput
                                       userInfo:nil];
      completionBlock(nil, error);
    });
    return;
  }
  completionBlock = [completionBlock copy];
  PFUser *user = [PFUser user];
  user.email = email;
  user.password = password;
  [user signUpInBackgroundWithBlock:^(BOOL success, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (!success) {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                                     code:RKAuthClientEmailHandlerErrorUnknown
                                                 userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(nil, errorResult);
      } else {
        // Even if successful, the underlying API may still return a filled in error, therefore,
        // we should propagate this error upwards if it exists.
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(user, errorResult);
      }
    });
  }];
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(RKAuthClientUserBlock)completionBlock
         callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  } else if (!email || !password) {
    dispatch_async(callbackQueue, ^{
      NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                           code:RKAuthClientEmailHandlerErrorMissingInput
                                       userInfo:nil];
      completionBlock(nil, error);
    });
    return;
  }
  [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (!user) {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(nil, errorResult);
      } else {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(user, errorResult);
      }
    });
  }];
}

- (void)changePasswordForEmail:(NSString *)email
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                    completion:(RKAuthClientSuccessBlock)completionBlock
                 callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientEmailHandlerErrorNotPossible
                                     userInfo:nil];
    completionBlock(error, NO);
  });
}

- (void)sendPasswordResetForEmail:(NSString *)email
                       completion:(RKAuthClientSuccessBlock)completionBlock
                    callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  } else if (!email) {
    dispatch_async(callbackQueue, ^{
      NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientEmailHandlerErrorMissingInput
                                     userInfo:nil];
      completionBlock(error, NO);
    });
    return;
  }
  [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
    dispatch_async(callbackQueue, ^{
      if (!succeeded) {
        NSError *errorResult = nil;
        if (!error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorUnknown
                                        userInfo:nil];
        } else {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      } else {
        NSError *errorResult = nil;
        if (error) {
          errorResult = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                            code:RKAuthClientEmailHandlerErrorServiceError
                                        userInfo:@{kRKAuthClientServiceErrorKey: error}];
        }
        completionBlock(errorResult, succeeded);
      }
    });
  }];
}

- (void)removeUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientSuccessBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(callbackQueue, @"callback queue must not be nil");
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientEmailHandlerErrorNotPossible
                                     userInfo:nil];
    completionBlock(error, NO);
  });
}

@end
