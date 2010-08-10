//
//  AuthorizationViewController.h
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-26.
//  Copyright 2010 Hugo Wetterberg. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthorizationViewController : UIViewController {
    // These are instance variables that will hold pointers
    // to interface elements.
    UIButton *authorizeButton;
    UIButton *resetButton;
    UILabel *doinGreatLabel;
}

// Declaration of properties, this is the same as declaring
// - (UIButton)authorizeButton;
// - (void)setAuthorizeButton:(UIButton *);
// ...but a more semantically cohesive declaration. There are
// other benefits, like the ability to @synthesize properties,
// and some memory-management assistance.
// see http://www.google.com/search?q=objective+c+properties
// for more details.
// IBOutlet is a keyword 
// that's removed by the preprocessor (never compiled)
// and is used to tell Interface Builder that it can
// assign objects to them.
@property (retain) IBOutlet UIButton *authorizeButton;
@property (retain) IBOutlet UIButton *resetButton;
@property (retain) IBOutlet UILabel *doinGreatLabel;

// Class methods, the "-"-sign denotes a instance method
// the "+"-sign would be used for class methods. IBAction
// is just a alias for void, but it works just like IBOutlet
// and lets Interface Builder know that it can set the method
// as a target for actions.
- (IBAction)requestAuthorization;
- (IBAction)resetAuthorization;

@end
