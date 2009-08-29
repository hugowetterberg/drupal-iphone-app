//
//  NodeListController.h
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-29.
//  Copyright 2009 Good Old. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"

@interface NodeListController : UITableViewController {
    RESTClient *client;
    NSArray *nodes;
}

- (id)initWithStyle:(UITableViewStyle)style restClient:(RESTClient *)aClient;

@end
