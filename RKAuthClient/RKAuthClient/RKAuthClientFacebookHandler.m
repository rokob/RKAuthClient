//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientFacebookHandler.h"

@implementation RKAuthClientFacebookHandler

- (void)loginToFacebookWithAppId:(NSString *)appId
                     permissions:(NSArray *)permissions
                        audience:(NSString *)audience
                      completion:(RKAuthClientUserBlock)completionBlock
                   callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)disconnectFromFacebookWithCompletion:(RKAuthClientErrorBlock)completionBlock
                               callbackQueue:(dispatch_queue_t)callbackQueue
{

}

@end
