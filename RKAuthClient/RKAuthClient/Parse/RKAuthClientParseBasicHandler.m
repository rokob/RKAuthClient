//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParseBasicHandler.h"

#import <Parse/Parse.h>

@implementation RKAuthClientParseBasicHandler

- (void)checkAuthStatusWithBlock:(RKAuthClientUserBlock)block callbackQueue:(dispatch_queue_t)callbackQueue
{
  dispatch_async(callbackQueue, ^{
    NSError *error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientBasicHandlerErrorUnimplemented
                                     userInfo:nil];
    block(nil, error);
  });
}

- (void)logout
{
  // do nothing
}

@end
