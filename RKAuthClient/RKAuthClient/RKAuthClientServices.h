//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

#import "RKAuthClientTypes.h"

@protocol RKAuthClientBasic <NSObject>

- (void)checkAuthStatusWithBlock:(RKAuthClientUserBlock)block
                   callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)logout;

@end

@protocol RKAuthClientEmail <NSObject>

- (void)createUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientUserBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(RKAuthClientUserBlock)completionBlock
         callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)changePasswordForEmail:(NSString *)email
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                    completion:(RKAuthClientSuccessBlock)completionBlock
                 callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)sendPasswordResetForEmail:(NSString *)email
                       completion:(RKAuthClientSuccessBlock)completionBlock
                    callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)removeUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientSuccessBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue;

@end

@protocol RKAuthClientFacebook <NSObject>

- (void)loginToFacebookWithAppId:(NSString *)appId
                     permissions:(NSArray *)permissions
                        audience:(NSString *)audience
                      completion:(RKAuthClientUserBlock)completionBlock
                   callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)disconnectFromFacebookWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                               callbackQueue:(dispatch_queue_t)callbackQueue;

@end

@protocol RKAuthClientTwitter <NSObject>

- (void)loginToTwitterWithAppId:(NSString *)appId
        multipleAccountsHandler:(int(^)(NSArray *usernames))accountSelection
                     completion:(RKAuthClientUserBlock)completionBlock
                  callbackQueue:(dispatch_queue_t)callbackQueue;

- (void)disconnectFromTwitterWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                              callbackQueue:(dispatch_queue_t)callbackQueue;

@end
