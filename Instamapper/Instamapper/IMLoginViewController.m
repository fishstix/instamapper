//
//  IMLoginViewController.m
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "IMLoginViewController.h"

#import "IMLoginProvider.h"

@interface IMLoginViewController ()

@end

@implementation IMLoginViewController
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark LOGIN

- (IBAction)login:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [[IMLoginProvider sharedProvider] loginWithUsername:username Password:password];
}


@end
