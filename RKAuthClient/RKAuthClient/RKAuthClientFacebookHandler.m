//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientFacebookHandler.h"

@implementation RKAuthClientFacebookHandler

- (void)loginToFacebookWithAppId:(NSString *)appId
                     permissions:(NSArray *)permissions
                        audience:(NSString *)audience
                      completion:(RKAuthClientUserBlock)completionBlock
                   callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!appId) {
      code = RKAuthClientFacebookHandlerErrorMissingAppId;
    } else {
      code = RKAuthClientFacebookHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(nil, error);
  });
}

- (void)disconnectFromFacebookWithCompletion:(RKAuthClientErrorBlock)completionBlock
                               callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientFacebookHandlerErrorUnimplemented
                                     userInfo:nil];
    completionBlock(error);
  });
}

@end
