//
//  NodeListController.m
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-29.
//  Copyright 2009 Good Old. All rights reserved.
//

#import "NodeListController.h"

@implementation NodeListController

- (id)initWithStyle:(UITableViewStyle)style restClient:(RESTClient *)aClient {
    if (self = [super initWithStyle:style]) {
        client = [aClient retain];
        
        // Set some info for the tab bar, we'll use one of the built in items this time
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
        
        // The only parameters we need is some sorting stuff,
        // probably redundant, but it showcases parameter sending
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setObject:@"created" forKey:@"sort_field"];
        [params setObject:@"DESC" forKey:@"sort_order"];
        
        // Tell the rest client to load the node index
        // We provide two selectors for callbacks, one
        // for success and one for failure
        [client getResourceAsync:[NSURL URLWithString:@"http://drupaliphone.local/services/rest/node.json"] 
                          method:@"GET" 
                      parameters:params 
                          target:self 
                        selector:@selector(restRequest:nodesLoaded:) 
                    failSelector:@selector(restRequest:nodesFailedToLoad:)];
    }
    return self;
}

- (void)restRequest:(id)request nodesLoaded:(NSArray *)loadedNodes {
    // Store and retain the results
    nodes = [loadedNodes retain];
    // ...and tell the table view to load the new data
    [self.tableView reloadData];
}

- (void)restRequest:(id)request nodesFailedToLoad:(NSError *)error {
    // Tell the user about the failure
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to load nodes" 
                                                    message:[error localizedDescription] 
                                                   delegate:nil cancelButtonTitle:@"Ok" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// We'll pass the node count if they've been
// loaded, otherwise we'll return zero.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    if (nodes) {
        count = [nodes count];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Node cell";
    
    // Cells are reused to increase performance
    // when scrolling a table view.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // Create a new cell if we didn't get one to reuse
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // Get the node and set the label text for the cell
    NSDictionary *node = [nodes objectAtIndex:indexPath.row];
    cell.textLabel.text = [node objectForKey:@"title"];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

