//
//  DrupalAppAppDelegate.h
//  DrupalApp
//
//  Created by Hugo Wetterberg on 2009-08-26.
//  Copyright Good Old 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrupalAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

