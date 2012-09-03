//
//  IMMasterController.m
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "IMMasterController.h"

#import "MKDSlideViewController.h"
#import "IMMenuViewController.h"
#import "IMDevicesViewController.h"

#import "IMLoginProvider.h"
#import "IMLoginViewController.h"

@interface IMMasterController() <IMLoginDelegate>

@property (nonatomic, strong) MKDSlideViewController *slideController;
@property (nonatomic, strong) IMMenuViewController *menuController;
@property (nonatomic, strong) IMDevicesViewController *devicesController;
@property (nonatomic, strong) IMLoginViewController *loginController;

+ (IMMasterController*) sharedController;
@end

@implementation IMMasterController {
    MKDSlideViewController *_slideController;
}
@synthesize slideController = _slideController;

#pragma mark -
#pragma mark SINGLETON

static IMMasterController *instance = NULL;

+ (IMMasterController*) sharedController
{
    @synchronized(self)
    {
        if (instance == NULL) {
            instance = [[IMMasterController alloc] init];
        }
    }
    
    return instance;
}

#pragma mark -
#pragma mark INIT

- (id) init
{
    self = [super init];
    
    if (self) {
        //
        self.menuController = [[IMMenuViewController alloc] initWithNibName:@"IMMenuViewController" bundle:nil];
        self.devicesController = [[IMDevicesViewController alloc] initWithNibName:@"IMDevicesViewController" bundle:nil];
        self.loginController = [[IMLoginViewController alloc] initWithNibName:@"IMLoginViewController" bundle:nil];
        
        self.slideController = [[MKDSlideViewController alloc] initWithRootViewController:self.devicesController];
        [self.slideController setLeftViewController:self.menuController rightViewController:self.menuController];
    }
    
    return self;
}

+ (void) initWithWindow:(UIWindow *)window
{
    [window setRootViewController:[[IMMasterController sharedController] slideController]];
    
    if (![[IMLoginProvider sharedProvider] isLoggedIn]) {
        [[IMMasterController sharedController] didLogout];
    }
}

#pragma mark - 
#pragma mark NAVIGATION


#pragma mark - 
#pragma mark LOGIN DELEGATION

- (void) didLogin
{
    
}

- (void) didLogout
{
    [[UIWindow topMostController] presentViewController:self.loginController animated:YES completion:^(void) {}];
}

- (void) loginFailed
{
    
}


@end
