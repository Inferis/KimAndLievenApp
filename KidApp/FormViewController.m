//
//  FormViewController.m
//  KidApp
//
//  Created by Tom Adriaenssen on 11/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "FormViewController.h"
#import "TextFieldCell.h"

@implementation FormViewController

@synthesize tableView = _tableView;
@synthesize person = _person, backgroundImageView = _backgroundImageView;
@synthesize nameField = _nameField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [editingPath release];
    [super dealloc];
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
    
    self.title = self.person;
    self.navigationController.navigationBar.tintColor = [self.person isEqualToString:@"Lieven"] 
        ? [UIColor colorWithRed:0.314 green:0.573 blue:0.816 alpha:1.000]
        : [UIColor colorWithRed:0.890 green:0.427 blue:0.863 alpha:1.000];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];

    UIView* view = [[_tableView subviews] objectAtIndex:0];
    view.alpha = 0;
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
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Keyboard handling

- (NSIndexSet*)allIndexesExcept:(NSIndexPath*)path {
    NSMutableIndexSet* indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 6)];
    if (path != nil) [indexes removeIndex:path.section];
    return indexes;
}


- (void)hideOthers {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UITableViewCell *cell = (UITableViewCell*)[[[keyWindow performSelector:@selector(firstResponder)] superview] superview];

    editingPath = [[_tableView indexPathForCell:cell] retain];
    
    [_tableView deleteSections:[self allIndexesExcept:editingPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    [self hideOthers];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSIndexSet* indexes = [self allIndexesExcept:editingPath];

    [editingPath release];
    editingPath = nil;

    [_tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return editingPath == nil ? 6 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString* title = [[@"Naam van het kind:Geboortedatum:Geboorteuur:Geslacht:Lengte:Gewicht" componentsSeparatedByString:@":"] objectAtIndex:section];

    UILabel* label = [[[UILabel alloc] initWithFrame:(CGRect) { 25, 0, tableView.frame.size.width, 44 }] autorelease];
    label.text = title;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:22]];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for %@", indexPath);
    static NSString *CellIdentifier = @"NormalTextFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        
    return cell;
}


@end
