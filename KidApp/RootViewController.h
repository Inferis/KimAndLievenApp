//
//  RootViewController.h
//  KidApp
//
//  Created by Tom Adriaenssen on 11/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
