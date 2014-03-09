//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClient.h"

#import "RKAuthClientBasicHandler.h"
#import "RKAuthClientEmailHandler.h"
#import "RKAuthClientFacebookHandler.h"
#import "RKAuthClientTwitterHandler.h"

@interface RKAuthClientConfiguration : NSObject <RKAuthClientConfiguration>
+ (instancetype)defaultConfiguration;
@property (nonatomic, readwrite, strong) id<RKAuthClientBasic> basicHandler;
@property (nonatomic, readwrite, strong) id<RKAuthClientEmail> emailHandler;
@property (nonatomic, readwrite, strong) id<RKAuthClientFacebook> facebookHandler;
@property (nonatomic, readwrite, strong) id<RKAuthClientTwitter> twitterHandler;
@end

#pragma mark -
#pragma mark RKAuthClient Implementation

@implementation RKAuthClient
{
  id<RKUser> _currentUser;
  NSMapTable *_listeners;

  id<RKAuthClientBasic> _basicHandler;
  id<RKAuthClientEmail> _emailHandler;
  id<RKAuthClientFacebook> _facebookHandler;
  id<RKAuthClientTwitter> _twitterHandler;
}

#pragma mark Lifecycle

- (id)init
{
  return [self initWithConfiguration:NULL];
}

- (id)initWithConfiguration:(RKAuthClientConfigurationBlock)configurationBlock
{
  if ((self = [super init])) {
    _listeners = [NSMapTable weakToStrongObjectsMapTable];
    RKAuthClientConfiguration *configuration = [RKAuthClientConfiguration defaultConfiguration];
    if (configurationBlock) {
      configurationBlock(configuration);
    }
    _basicHandler = configuration.basicHandler;
    _emailHandler = configuration.emailHandler;
    _facebookHandler = configuration.facebookHandler;
    _twitterHandler = configuration.twitterHandler;
  }
  return self;
}

#pragma mark -
#pragma mark Basic Auth

- (void)checkAuthStatusWithBlock:(RKAuthClientUserBlock)block
                   callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_basicHandler checkAuthStatusWithBlock:block callbackQueue:callbackQueue];
}

- (void)logout
{
  [_basicHandler logout];
  [self enumerateListenersWithBlock:^(id<RKAuthClientListener> listener, dispatch_queue_t queue) {
    dispatch_async(queue, ^{
      [listener userDidLogout];
    });
  }];
}

#pragma mark -
#pragma mark Listeners

- (void)addListener:(id<RKAuthClientListener>)listener callbackQueue:(dispatch_queue_t)callbackQueue
{
  NSAssert(listener != nil, @"Listener must not be nil");
  if (callbackQueue) {
    [_listeners setObject:callbackQueue forKey:listener];
  } else {
    [_listeners setObject:dispatch_get_main_queue() forKey:listener];
  }
}

- (void)removeListener:(id<RKAuthClientListener>)listener callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_listeners removeObjectForKey:listener];
}

- (void)enumerateListenersWithBlock:(void(^)(id<RKAuthClientListener> listener, dispatch_queue_t queue))block
{
  if (!block) {
    return;
  }
  NSMapTable *listeners = [_listeners copy];
  for (id<RKAuthClientListener> listener in listeners) {
    block(listener, (dispatch_queue_t)[listeners objectForKey:listener]);
  }
}

#pragma mark -
#pragma mark RKAuthClientEmail

- (void)createUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientUserBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_emailHandler createUserWithEmail:email password:password completion:completionBlock callbackQueue:callbackQueue];
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(RKAuthClientUserBlock)completionBlock
         callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_emailHandler loginWithEmail:email password:password completion:completionBlock callbackQueue:callbackQueue];
}

- (void)changePasswordForEmail:(NSString *)email
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                    completion:(RKAuthClientSuccessBlock)completionBlock
                 callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_emailHandler changePasswordForEmail:email
                            oldPassword:oldPassword
                            newPassword:newPassword
                             completion:completionBlock
                          callbackQueue:callbackQueue];
}

- (void)sendPasswordResetForEmail:(NSString *)email
                       completion:(RKAuthClientSuccessBlock)completionBlock
                    callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_emailHandler sendPasswordResetForEmail:email completion:completionBlock callbackQueue:callbackQueue];
}

- (void)removeUserWithEmail:(NSString *)email
                   password:(NSString *)password
                 completion:(RKAuthClientSuccessBlock)completionBlock
              callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_emailHandler removeUserWithEmail:email password:password completion:completionBlock callbackQueue:callbackQueue];
}

#pragma mark -
#pragma mark RKAuthClientFacebook

- (void)loginToFacebookWithAppId:(NSString *)appId
                     permissions:(NSArray *)permissions
                        audience:(NSString *)audience
                      completion:(RKAuthClientUserBlock)completionBlock
                   callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_facebookHandler loginToFacebookWithAppId:appId
                                 permissions:permissions
                                    audience:audience
                                  completion:completionBlock
                               callbackQueue:callbackQueue];
}

- (void)disconnectFromFacebookWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                               callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_facebookHandler disconnectFromFacebookWithCompletion:completionBlock callbackQueue:callbackQueue];
}

#pragma mark -
#pragma mark RKAuthClientTwitter

- (void)loginToTwitterWithAppId:(NSString *)appId
        multipleAccountsHandler:(int (^)(NSArray *))accountSelection
                     completion:(RKAuthClientUserBlock)completionBlock
                  callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_twitterHandler loginToTwitterWithAppId:appId
                   multipleAccountsHandler:accountSelection
                                completion:completionBlock
                             callbackQueue:callbackQueue];
}

- (void)disconnectFromTwitterWithCompletion:(RKAuthClientSuccessBlock)completionBlock
                              callbackQueue:(dispatch_queue_t)callbackQueue
{
  [_twitterHandler disconnectFromTwitterWithCompletion:completionBlock callbackQueue:callbackQueue];
}

@end

#pragma mark -
#pragma mark RKAuthClientConfiguration Implementation

@implementation RKAuthClientConfiguration

+ (instancetype)defaultConfiguration
{
  id<RKAuthClientBasic> basicHandler = [[RKAuthClientBasicHandler alloc] init];
  id<RKAuthClientEmail> emailHandler = [[RKAuthClientEmailHandler alloc] init];
  id<RKAuthClientFacebook> facebookHandler = [[RKAuthClientFacebookHandler alloc] init];
  id<RKAuthClientTwitter> twitterHandler = [[RKAuthClientTwitterHandler alloc] init];

  return [[self alloc] initWithBasicHandler:basicHandler
                               emailHandler:emailHandler
                            facebookHandler:facebookHandler
                             twitterHandler:twitterHandler];
}

- (instancetype)initWithBasicHandler:(id<RKAuthClientBasic>)basicHandler
                        emailHandler:(id<RKAuthClientEmail>)emailHandler
                     facebookHandler:(id<RKAuthClientFacebook>)facebookHandler
                      twitterHandler:(id<RKAuthClientTwitter>)twitterHandler
{
  if ((self = [super init])) {
    _basicHandler = basicHandler;
    _emailHandler = emailHandler;
    _facebookHandler = facebookHandler;
    _twitterHandler = twitterHandler;
  }
  return self;
}

@end
