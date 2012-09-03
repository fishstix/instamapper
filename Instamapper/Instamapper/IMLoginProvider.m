//
//  IMLoginProvider.m
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "IMLoginProvider.h"

@implementation IMLoginProvider
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark SINGLETON

static IMLoginProvider *instance = NULL;

+ (IMLoginProvider*) sharedProvider
{
    @synchronized(self) {
        if (instance == NULL) {
            instance = [[IMLoginProvider alloc] init];
        }
    }
    
    return instance;
}

#pragma mark -
#pragma mark LOGIN

- (void) loginWithUsername:(NSString *)username Password:(NSString *)password
{
    
}

- (void) logout
{
    
}

- (BOOL) isLoggedIn
{
    return NO;
}

@end
