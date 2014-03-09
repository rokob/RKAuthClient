//  Copyright (c) 2014 rokob. All rights reserved.

#import "PFUser+RKAuthClient.h"

@implementation PFUser (RKAuthClient)

- (NSString *)token
{
  return [self sessionToken];
}

- (NSString *)userId
{
  return [self username];
}

// email is already defined
// isNew is already defined

// FIX
- (ACAccount *)thirdPartyUserAccount
{
  return nil;
}

// FIX
- (NSDictionary *)thirdPartyUserData
{
  return nil;
}

@end
