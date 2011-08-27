//
//  TextFieldCell.m
//  FleetExpert
//
//  Created by Jelle Vandebeeck on 30/05/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize field = _field;
@synthesize suffix = _suffix;
@synthesize delegate = _delegate;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.field = [[UITextField alloc] initWithFrame:CGRectMake(0, 11, 210, 34)];
        self.field.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
        self.field.placeholder = @"vul iets in...";
        self.field.textColor = [UIColor blackColor];
        self.field.textAlignment = UITextAlignmentLeft;
        self.field.autocorrectionType = UITextAutocorrectionTypeNo;
        self.field.opaque = NO;
        self.field.backgroundColor = nil;
        self.field.returnKeyType = UIReturnKeyDone;
        self.field.keyboardType = UIKeyboardTypeAlphabet;
        self.field.delegate = self;
		[self.contentView addSubview:self.field];

        self.suffix = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 210, 34)];
        self.suffix.font = [UIFont fontWithName:@"HelveticaNeue" size:22];
        self.suffix.textColor = [UIColor blackColor];
        self.suffix.textAlignment = UITextAlignmentRight;
        self.suffix.opaque = NO;
        self.suffix.backgroundColor = nil;
		[self.contentView addSubview:self.suffix];
}
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate finishedEditing:textField.text];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.suffix.text != nil && self.suffix.text.length > 0) {
        self.suffix.alpha = 1;
        CGSize sz = [self.suffix.text sizeWithFont:self.suffix.font];
        self.suffix.frame = (CGRect) { self.contentView.frame.size.width - 10 - sz.width, 11, sz.width, sz.height }; 
        self.field.frame = (CGRect) { 10, 11, self.contentView.frame.size.width - 30 - sz.width, 34 };
    }
    else {
        self.field.frame = (CGRect) { 10, 11, self.contentView.frame.size.width - 20, 34 };
        self.suffix.alpha = 0;
    }
}

#pragma mark - Memory

- (void)dealloc {
    [self.field release];
    [super dealloc];
}

@end
