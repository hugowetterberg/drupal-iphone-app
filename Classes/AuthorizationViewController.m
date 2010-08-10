//
//  AuthorizationViewController.m
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-26.
//  Copyright 2010 Hugo Wetterberg. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "AuthorizationManager.h"
#import "NSString+URLEncoding.h"

@interface AuthorizationViewController (Private)

- (void)updateInterfaceAnimated:(BOOL)animated;

@end

@implementation AuthorizationViewController

@synthesize authorizeButton, resetButton, doinGreatLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Authorization" image:[UIImage imageNamed:@"info.png"] tag:0];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)requestAuthorization {
    AuthorizationManager *manager = [AuthorizationManager sharedManager];
    
    // Verify access if we got a access token
    if ([manager requestToken]) {
        [manager getAccessToken];
        [self updateInterfaceAnimated:YES];
    }
    else {
        // Get the request token
        [manager getRequestToken];
		[self updateInterfaceAnimated:FALSE];
    }

}

- (void)resetAuthorization {
    AuthorizationManager *manager = [AuthorizationManager sharedManager];
    [manager resetAuthorization];
    [self updateInterfaceAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateInterfaceAnimated:FALSE];
}

- (void)updateInterfaceAnimated:(BOOL)animated {
    AuthorizationManager *manager = [AuthorizationManager sharedManager];
    // Disable the authorize button if we already have access
    authorizeButton.enabled = ![manager hasAccess];
    // Change the title of the authorize button if
    // we have a request token.
    if ([manager requestToken]) {
        [authorizeButton setTitle:@"Verify authorization" forState:UIControlStateNormal];
    }
    
    // Adding some animation code here, just to show you
    // how easy it is to get good-looking animations
    // on the iPhone.
    if (animated) {
        [UIView beginAnimations:@"showSuccessLabel" context:nil];
        [UIView setAnimationDuration:0.3];
    }
    
    if ([manager hasAccess]) {
        authorizeButton.alpha = 0.0;
        doinGreatLabel.alpha = 1.0;
    }
    else {
        authorizeButton.alpha = 1.0;
        doinGreatLabel.alpha = 0.0;
    }
    
    if (animated) {
        [UIView commitAnimations];
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
