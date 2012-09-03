//
//  IMLoginProvider.h
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMLoginDelegate <NSObject>

- (void) didLogin;
- (void) didLogout;
- (void) loginFailed;

@end

@interface IMLoginProvider : NSObject {
}

@property (nonatomic, weak) id<IMLoginDelegate> delegate;

+ (IMLoginProvider*) sharedProvider;

- (void) loginWithUsername:(NSString*)username Password:(NSString*)password;
- (void) logout;

- (BOOL) isLoggedIn;

@end
