//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParseBasicHandler.h"

#import "PFUser+RKAuthClient.h"

@implementation RKAuthClientParseBasicHandler

- (void)checkAuthStatusWithBlock:(RKAuthClientUserBlock)block callbackQueue:(dispatch_queue_t)callbackQueue
{
  PFUser *user = [PFUser currentUser];
  dispatch_async(callbackQueue, ^{
    NSError *error = nil;
    if (!user) {
      error = [NSError errorWithDomain:kRKAuthClientErrorDomain
                                         code:RKAuthClientBasicHandlerErrorNoUser
                                     userInfo:nil];
    }
    block(user, error);
  });
}

- (void)logout
{
  [PFUser logOut];
}

@end
