//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientParse.h"

#import "RKAuthClientParseBasicHandler.h"
#import "RKAuthClientParseEmailHandler.h"
#import "RKAuthClientParseFacebookHandler.h"
#import "RKAuthClientParseTwitterHandler.h"

@implementation RKAuthClientParse

+ (RKAuthClient *)parseAuthClient
{
  return [[RKAuthClient alloc] initWithConfiguration:[self defaultConfiguration]];
}

+ (RKAuthClientConfigurationBlock)defaultConfiguration
{
  id<RKAuthClientBasic> basicHandler = [[RKAuthClientParseBasicHandler alloc] init];
  id<RKAuthClientEmail> emailHandler = [[RKAuthClientParseEmailHandler alloc] init];
  id<RKAuthClientFacebook> facebookHandler = [[RKAuthClientParseFacebookHandler alloc] init];
  id<RKAuthClientTwitter> twitterHandler = [[RKAuthClientParseTwitterHandler alloc] init];

  return [^(id<RKAuthClientConfiguration> configuration) {
    [configuration setBasicHandler:basicHandler];
    [configuration setEmailHandler:emailHandler];
    [configuration setFacebookHandler:facebookHandler];
    [configuration setTwitterHandler:twitterHandler];
  } copy];
}

@end
