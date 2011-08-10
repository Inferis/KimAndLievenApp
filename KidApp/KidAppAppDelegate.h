//
//  KidAppAppDelegate.h
//  KidApp
//
//  Created by Tom Adriaenssen on 10/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KidAppAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
