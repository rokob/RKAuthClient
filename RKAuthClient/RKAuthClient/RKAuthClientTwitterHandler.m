//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientTwitterHandler.h"

@implementation RKAuthClientTwitterHandler

- (void)loginToTwitterWithAppId:(NSString *)appId
        multipleAccountsHandler:(int (^)(NSArray *))accountSelection
                     completion:(RKAuthClientUserBlock)completionBlock
                  callbackQueue:(dispatch_queue_t)callbackQueue
{

}

- (void)disconnectFromTwitterWithCompletion:(RKAuthClientErrorBlock)completionBlock
                              callbackQueue:(dispatch_queue_t)callbackQueue
{

}

@end
