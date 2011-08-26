//
//  SexController.h
//  KidApp
//
//  Created by Tom Adriaenssen on 26/08/11.
//  Copyright (c) 2011 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SexControllerDelegate <NSObject>

- (void)dismissAndSave:(BOOL)save withValue:(NSString*)value;

@end

@interface SexController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet id<SexControllerDelegate> delegate;

- (id)initWithSex:(NSString*)date;

- (CGSize)popoverSize;

- (IBAction)cancelPressed;

@end
