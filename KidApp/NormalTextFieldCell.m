//
//  NormalTextFieldCell.m
//  FleetExpert
//
//  Created by Jelle Vandebeeck on 09/06/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "NormalTextFieldCell.h"

@implementation NormalTextFieldCell
@synthesize field;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 12, 30, 25)];
        mainLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        mainLabel.textColor = [UIColor blackColor];
		mainLabel.backgroundColor = [UIColor clearColor];
        mainLabel.text = @"fdj";
        mainLabel.opaque = NO;
        mainLabel.backgroundColor = nil;
		[self.contentView addSubview:mainLabel];
        [mainLabel release];
        
        self.field = [[UITextField alloc] initWithFrame:CGRectMake(10, 11, 185, 35)];
        self.field.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        self.field.textColor = [UIColor blackColor];
        self.field.textAlignment = UITextAlignmentRight;
		self.field.backgroundColor = [UIColor clearColor];
        self.field.autocorrectionType = UITextAutocorrectionTypeNo;
        self.field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.field.opaque = NO;
        self.field.backgroundColor = nil;
		[self.contentView addSubview:self.field];
    }
    return self;
}

#pragma mark - Memory

- (void)dealloc {
    self.field = nil;
    
    [super dealloc];
}

@end
