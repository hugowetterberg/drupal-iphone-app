//
//  DrupalAppAppDelegate.m
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-26.
//  Copyright Good Old 2009. All rights reserved.
//

#import "DrupalAppAppDelegate.h"
#import "AuthorizationViewController.h"
#import "AuthorizationManager.h"
#import "OAConsumer.h"
#import "RESTClient.h"
#import "OAuthRESTClientDelegate.h"
#import "NodeListController.h";

@implementation DrupalAppAppDelegate

@synthesize window, tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Create a shared authorization manager
    NSURL *baseUrl = [NSURL URLWithString:@"http://drupaliphone.local"];
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"92dyZAANYnepnjG69suXV775rKDgnhzi" secret:@"ffRTh8pP9gfWSFpu3NJt6j5v6j4ENZSf"];
    AuthorizationManager *manager = [[[AuthorizationManager alloc] initWithConsumer:consumer baseUrl:baseUrl] autorelease];
    [AuthorizationManager setSharedManager:manager];
    
    // Create the REST client
    RESTClient *client = [[[RESTClient alloc] init] autorelease];
    OAuthRESTClientDelegate *oauthDelegate = [[OAuthRESTClientDelegate alloc] initWithAuthorizationManager:manager];
    client.delegate = [oauthDelegate autorelease];
    
    // Create a instance of our controller, specifying the name of our xib
    AuthorizationViewController *auth = [[[AuthorizationViewController alloc] initWithNibName:@"AuthorizationView" bundle:nil] autorelease];
    
    // Create a instance of our node list controller
    NodeListController *nodeList = [[[NodeListController alloc] initWithStyle:UITableViewStylePlain restClient:client] autorelease];
    
    // Create an array of controllers
    NSArray *controllers = [[[NSArray alloc] initWithObjects:nodeList, auth, nil] autorelease];
    
    // Pass the controller array to the tab bar controller
    [tabBarController setViewControllers:controllers];
    
    // Select the authorization view if we haven't been authorized
    if (![manager hasAccess]) {
        [tabBarController setSelectedIndex:1];
    }
    
    // Add the tab bar view to our window
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
