//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientEmailHandler.h"

@implementation RKAuthClientEmailHandler

- (void)createUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientUserBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(RKAuthClientUserBlock)completionBlock
         callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)changePasswordForEmail:(NSString *)email
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                    completion:(RKAuthClientPasswordChangeBlock)completionBlock
                 callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)sendPasswordResetForEmail:(NSString *)email
                       completion:(RKAuthClientErrorBlock)completionBlock
                    callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)removeUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientErrorBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{

}

@end
