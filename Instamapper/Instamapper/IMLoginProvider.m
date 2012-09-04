//
//  IMLoginProvider.m
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "IMLoginProvider.h"

#import "FSHTTPRequest.h"

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
    DLog(@"User %@ PW %@", username, password);
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.instamapper.com/fe?action=login&username=%@&password=%@", username, password];
    NSURL *url = [NSURL URLWithString:urlString];
    DLog(@"Login URL: %@", urlString);
    FSHTTPRequest *request = [[FSHTTPRequest alloc] initWithURL:url timeout:10.0f method:@"POST"];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:@"1", NSHTTPCookieValue,
                                     @"t", NSHTTPCookieName,
                                     nil]];
//    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[NSHTTPCookie requestHeaderFieldsWithCookies:[NSArray arrayWithObject:cookie]]];
//    [request setHeaders:headers];
    [request addRequestHeader:@"Set-Cookie" value:@"t=1"];
//    [self isLoggedIn];
    
    [request start:^(NSData* data) {
        // Completion
        if ([self isLoggedIn]) {
            DLog(@"Login Completion");
            if ([self.delegate respondsToSelector:@selector(didLogin)]) {
                [self.delegate didLogin];
            }
        }
        
        // Response
        NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        DLog(@"Response: %@", response);
        
    }:^(FSHTTPRequest* request) {
        // Failure
        DLog(@"Login Failure");
        if ([self.delegate respondsToSelector:@selector(loginFailed)]) {
            [self.delegate loginFailed];
        }
    }];
}

- (void) logout
{
    // blah
    
    if ([self.delegate respondsToSelector:@selector(didLogout)]) {
        [self.delegate didLogout];
    }
}

- (BOOL) isLoggedIn
{
    //This only works for anonymous users that login or when the 'remember me?' token is checked - which does not exist in the iPhone apps
    DLog(@"DEM COOKIES");
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        DLog(@"cookie name is %@", cookie.name);
        DLog(@"cookie value is %@", cookie.value);
    }

    return NO;
}

@end
