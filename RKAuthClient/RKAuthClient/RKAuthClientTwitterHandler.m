//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientTwitterHandler.h"

@implementation RKAuthClientTwitterHandler

- (void)loginToTwitterWithAppId:(NSString *)appId
        multipleAccountsHandler:(int (^)(NSArray *))accountSelection
                     completion:(RKAuthClientUserBlock)completionBlock
                  callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSInteger code = 0;
    if (!appId) {
      code = RKAuthClientTwitterHandlerErrorMissingAppId;
    } else {
      code = RKAuthClientTwitterHandlerErrorUnimplemented;
    }
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:code
                                     userInfo:nil];
    completionBlock(nil, error);
  });
}

- (void)disconnectFromTwitterWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                              callbackQueue:(dispatch_queue_t)callbackQueue
{
  if (!completionBlock) {
    return;
  }
  dispatch_async(callbackQueue, ^{
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientTwitterHandlerErrorUnimplemented
                                     userInfo:nil];
    completionBlock(error, NO);
  });
}

@end
