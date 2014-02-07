//
//  SignupViewController.m
//  iCatalog
//
//  Created by Siavash on 1/29/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "SignupViewController.h"
#import "ViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

- (IBAction)signup:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.email = self.email.text;
    user.password = self.password.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (succeeded) {
            [self performSegueWithIdentifier:@"welcome" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"welcome"]) {
        ViewController *vc = segue.destinationViewController;
        vc.userID = self.username.text;
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Signup";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
