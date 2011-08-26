//
//  DateController.h
//  KidApp
//
//  Created by Tom Adriaenssen on 25/08/11.
//  Copyright (c) 2011 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateControllerDelegate <NSObject>

- (void)dismissAndSave:(BOOL)save;

@end

@interface DateController : UIViewController {
@private
    UIDatePickerMode _mode;
    NSString* _value;
}

@property (nonatomic, retain) IBOutlet UIDatePicker* picker;
@property (nonatomic, retain) IBOutlet id<DateControllerDelegate> delegate;

- (id)initWithDate:(NSString*)date;
- (id)initWithTime:(NSString*)date;
- (NSString*)getDateValue;
- (NSString*)getTimeValue;

- (CGSize)popoverSize;

- (IBAction)donePressed;
- (IBAction)cancelPressed;

@end
