//
//  ViewController.m
//  LoginCounter
//
//  Created by Andy Lee on 2/19/13.
//  Copyright (c) 2013 Andy Lee. All rights reserved.
//

#import "ViewController.h"
#import "LCAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUser:(NSString*)username andPassword:(NSString *)password
{
    
}

- (void)loginUser:(NSString*)username andPassword:(NSString *)password
{
    
}

- (IBAction)loginPressed:(id)sender
{
    [[LCAPIClient sharedClient] loginWithUsername:usernameTextField.text andPassword:passwordTextField.text completionHandler:^(NSURLRequest *request, NSURLResponse *response, NSDictionary *results) {
        if ([[results objectForKey:@"errCode"] intValue] == 1) {
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat: @"You've logged in %i times", [[results objectForKey:@"count"] intValue]] delegate:self cancelButtonTitle:@"OKAY" otherButtonTitles: nil];
            [successAlert show];
        } else {
            NSString *title = @"Error";
            NSString *message = @"Error Unknown";
            switch ([[results objectForKey:@"errCode"] intValue]) {
                case -1:
                    title = @"ERR_BAD_CREDENTIALS";
                    message = @"Cannot find user/password pair in the database";
                    break;
                default:
                    break;
            }
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OKAY" otherButtonTitles: nil];
            [errorAlert show];
        }
    }];
}

- (IBAction) addPressed:(id)sender
{
    [[LCAPIClient sharedClient] addUsername:usernameTextField.text andPassword:passwordTextField.text completionHandler:^(NSURLRequest *request, NSURLResponse *response, NSDictionary *results) {
        if ([[results objectForKey:@"errCode"] intValue] == 1) {
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat: @"You've logged in %i times", [[results objectForKey:@"count"] intValue]] delegate:self cancelButtonTitle:@"OKAY" otherButtonTitles: nil];
            [successAlert show];
        } else {
            NSString *title = @"Error";
            NSString *message = @"Error Unknown";
            switch ([[results objectForKey:@"errCode"] intValue]) {
                case -2:
                    title = @"ERR_USER_EXISTS";
                    message = @"Trying to add a user that already exists";
                    break;
                case -3:
                    title = @"ERR_BAD_USERNAME";
                    message = @"Invalid user name (user name should be non-empty and at most 128 ascii characters long)";
                    break;
                case -4:
                    title = @"ERR_BAD_PASSWORD";
                    message = @"Invalid password (password should be at most 128 ascii characters)";
                    break;
                default:
                    break;
            }
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OKAY" otherButtonTitles: nil];
            [errorAlert show];
        }
    }];
    
}

@end
