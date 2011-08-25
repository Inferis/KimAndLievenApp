//
//  FormViewController.h
//  KidApp
//
//  Created by Tom Adriaenssen on 11/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSIndexPath* editingPath;
    NSArray* data;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSString* person;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, retain) IBOutlet UITextField* nameField;

@end
