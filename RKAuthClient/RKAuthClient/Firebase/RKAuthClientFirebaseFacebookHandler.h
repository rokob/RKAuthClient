//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

#import "RKAuthClientServices.h"

@class FirebaseSimpleLogin;

@interface RKAuthClientFirebaseFacebookHandler : NSObject <RKAuthClientFacebook>

- (instancetype)initWithSimpleLogin:(FirebaseSimpleLogin *)simpleLogin;

@end
