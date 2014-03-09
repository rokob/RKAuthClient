//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientFirebase.h"

#import <Firebase/Firebase.h>

#import "RKAuthClientFirebaseBasicHandler.h"
#import "RKAuthClientFirebaseEmailHandler.h"
#import "RKAuthClientFirebaseFacebookHandler.h"
#import "RKAuthClientFirebaseTwitterHandler.h"

@implementation RKAuthClientFirebase

+ (RKAuthClient *)firebaseAuthClientWithFirebase:(Firebase *)firebase
{
  return [[RKAuthClient alloc] initWithConfiguration:[self defaultConfigurationWithFirebase:firebase]];
}

+ (RKAuthClientConfigurationBlock)defaultConfigurationWithFirebase:(Firebase *)firebase
{
  id<RKAuthClientBasic> basicHandler = [[RKAuthClientFirebaseBasicHandler alloc] init];
  id<RKAuthClientEmail> emailHandler = [[RKAuthClientFirebaseEmailHandler alloc] init];
  id<RKAuthClientFacebook> facebookHandler = [[RKAuthClientFirebaseFacebookHandler alloc] init];
  id<RKAuthClientTwitter> twitterHandler = [[RKAuthClientFirebaseTwitterHandler alloc] init];

  return [^(id<RKAuthClientConfiguration> configuration) {
    [configuration setBasicHandler:basicHandler];
    [configuration setEmailHandler:emailHandler];
    [configuration setFacebookHandler:facebookHandler];
    [configuration setTwitterHandler:twitterHandler];
  } copy];
}

@end
