//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientEmailHandler.h"

@implementation RKAuthClientEmailHandler

- (void)createUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientUserBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!email || !password) {
      code = RKAuthClientEmailHandlerErrorMissingInput;
    } else {
      code = RKAuthClientEmailHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(nil, error);
  });
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(RKAuthClientUserBlock)completionBlock
         callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!email || !password) {
      code = RKAuthClientEmailHandlerErrorMissingInput;
    } else {
      code = RKAuthClientEmailHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(nil, error);
  });
}

- (void)changePasswordForEmail:(NSString *)email
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                    completion:(RKAuthClientPasswordChangeBlock)completionBlock
                 callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!email || !oldPassword || !newPassword) {
      code = RKAuthClientEmailHandlerErrorMissingInput;
    } else {
      code = RKAuthClientEmailHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(error, NO);
  });
}

- (void)sendPasswordResetForEmail:(NSString *)email
                       completion:(RKAuthClientErrorBlock)completionBlock
                    callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!email) {
      code = RKAuthClientEmailHandlerErrorMissingInput;
    } else {
      code = RKAuthClientEmailHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(error);
  });
}

- (void)removeUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientErrorBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!email || !password) {
      code = RKAuthClientEmailHandlerErrorMissingInput;
    } else {
      code = RKAuthClientEmailHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(error);
  });
}

@end
