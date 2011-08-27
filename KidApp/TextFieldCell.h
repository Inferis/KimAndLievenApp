//
//  TextFieldCell.h
//  FleetExpert
//
//  Created by Jelle Vandebeeck on 30/05/11.
//  Copyright 2011 10to1. All rights reserved.
//

@protocol TextFieldCellDelegate <NSObject>

- (void)finishedEditing:(NSString*)content;

@end

@interface TextFieldCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, retain) UITextField *field;
@property (nonatomic, retain) UILabel *suffix;
@property (nonatomic, retain) id<TextFieldCellDelegate> delegate;

@end
