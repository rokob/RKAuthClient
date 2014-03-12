//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

#import "RKAuthClientServices.h"

@class FirebaseSimpleLogin;

@interface RKAuthClientFirebaseBasicHandler : NSObject <RKAuthClientBasic>

- (instancetype)initWithSimpleLogin:(FirebaseSimpleLogin *)simpleLogin;

@end
