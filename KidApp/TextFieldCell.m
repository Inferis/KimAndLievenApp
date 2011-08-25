//
//  TextFieldCell.m
//  FleetExpert
//
//  Created by Jelle Vandebeeck on 30/05/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize field;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.field = [[UITextField alloc] initWithFrame:CGRectMake(0, 11, 210, 25)];
        self.field.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.field.frame = (CGRect) { 10, 11, self.bounds.size.width - 20, 25 };
}

#pragma mark - Memory

- (void)dealloc {
    [self.field release];
    [super dealloc];
}

@end
