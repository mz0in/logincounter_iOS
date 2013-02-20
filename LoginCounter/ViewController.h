//
//  ViewController.h
//  LoginCounter
//
//  Created by Andy Lee on 2/19/13.
//  Copyright (c) 2013 Andy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIButton *userAdd;
    IBOutlet UIButton *userLogin;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

- (IBAction)loginPressed:(id)sender;
- (IBAction)addPressed:(id)sender;

@end
