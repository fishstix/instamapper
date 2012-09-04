//
//  IMLoginViewController.h
//  Instamapper
//
//  Created by Charles Fisher on 9/2/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "FSViewController.h"

@interface IMLoginViewController : FSViewController

@property (nonatomic, strong) IBOutlet UITextField *usernameTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

- (IBAction)login:(id)sender;

@end
