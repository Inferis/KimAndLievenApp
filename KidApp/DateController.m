//
//  DateController.m
//  KidApp
//
//  Created by Tom Adriaenssen on 25/08/11.
//  Copyright (c) 2011 10to1. All rights reserved.
//

#import "DateController.h"

@implementation DateController

@synthesize picker = _picker;
@synthesize delegate = _delegate;

- (id)initWithDate:(NSString*)date
{
    self = [self initWithNibName:@"DateController" bundle:nil];
    if (self) {
        // Custom initialization
        _mode = UIDatePickerModeDate;
        _value = [date retain];
        self.view.frame = (CGRect) { 0, 0, 320, 216 };
    }

    return self;
}

- (id)initWithTime:(NSString*)time
{
    self = [self initWithNibName:@"DateController" bundle:nil];
    if (self) {
        // Custom initialization
        _mode = UIDatePickerModeTime;
        _value = [time retain];
        self.view.frame = (CGRect) { 0, 0, 320, 216 };
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    _picker.datePickerMode = _mode;
    _picker.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"nl_BE"] autorelease];

    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = _mode == UIDatePickerModeDate ? @"dd/MM/yyyy" : @"HH:mm";
    NSDate* date = [formatter dateFromString:_value];
    if (date == nil) {
        if (_mode == UIDatePickerModeDate)
            date = [[NSDate date] dateByAddingTimeInterval:60*60*24*30*9];
        else
            date = [NSDate date];
    }
    _picker.date = date;
    [_value release];
    _value = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString*)getDateValue {
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"dd/MM/yyyy";
    return [formatter stringFromDate:_picker.date];
}

- (NSString*)getTimeValue {
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"HH:mm";
    return [formatter stringFromDate:_picker.date];
}

- (CGSize)popoverSize {
    return (CGSize) { _picker.bounds.size.width, _picker.bounds.size.height + 44 };
}

- (IBAction)donePressed {
    [self.delegate dismissAndSave:YES];
}

- (IBAction)cancelPressed {
    [self.delegate dismissAndSave:NO];
}

@end
