//
//  NodeListController.h
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-29.
//  Copyright 2010 Hugo Wetterberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTClient.h"

@interface NodeListController : UITableViewController {
    NSArray *nodes;
}

- (id)initWithStyle:(UITableViewStyle)style;
- (void)loadNodes;

@end
