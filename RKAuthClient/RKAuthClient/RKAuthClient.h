//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

#import "RKAuthClientServices.h"
#import "RKAuthClientTypes.h"

@protocol RKAuthClientListener <NSObject>
- (void)userDidLogout;
@end

@protocol RKAuthClientConfiguration <NSObject>
- (void)setBasicHandler:(id<RKAuthClientBasic>)basicHandler;
- (void)setEmailHandler:(id<RKAuthClientEmail>)emailHandler;
- (void)setFacebookHandler:(id<RKAuthClientFacebook>)facebookHandler;
- (void)setTwitterHandler:(id<RKAuthClientTwitter>)twitterHandler;
@end
typedef void(^RKAuthClientConfigurationBlock)(id<RKAuthClientConfiguration> configuration);


@interface RKAuthClient : NSObject <RKAuthClientBasic, RKAuthClientEmail, RKAuthClientFacebook, RKAuthClientTwitter>

- (instancetype)init;
- (instancetype)initWithConfiguration:(RKAuthClientConfigurationBlock)configurationBlock;

- (void)addListener:(id<RKAuthClientListener>)listener callbackQueue:(dispatch_queue_t)callbackQueue;
- (void)removeListener:(id<RKAuthClientListener>)listener callbackQueue:(dispatch_queue_t)callbackQueue;

@end
