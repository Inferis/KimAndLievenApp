//
//  LabelView.m
//  KidApp
//
//  Created by Tom Adriaenssen on 26/08/11.
//  Copyright (c) 2011 10to1. All rights reserved.
//

#import "LabelView.h"

@implementation LabelView

- (id)initWithTitle:(NSString*)title frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel* label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        label.text = title;
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor darkGrayColor]];
        [label setShadowOffset:(CGSize) { 0, 1 }];
        [label setShadowColor:[UIColor lightGrayColor]];
        [label setTextAlignment:UITextAlignmentRight];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22]];
        [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:label];
    }
    return self;
}

- (void)layoutSubviews {
    ((UIView*)[[self subviews] objectAtIndex:0]).frame = (CGRect) { 35, 0, self.frame.size.width-70, self.frame.size.height };
}
@end
