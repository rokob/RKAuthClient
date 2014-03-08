//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKAuthClientFirebase.h"

@implementation RKAuthClientFirebase

+ (RKAuthClient *)firebaseAuthClient
{
  return [[RKAuthClient alloc] initWithConfiguration:[self defaultConfiguration]];
}

+ (RKAuthClientConfigurationBlock)defaultConfiguration
{
  return [^(id<RKAuthClientConfiguration> configuration) {
    [configuration setBasicHandler:nil];
    [configuration setEmailHandler:nil];
    [configuration setFacebookHandler:nil];
    [configuration setTwitterHandler:nil];
  } copy];
}

@end
