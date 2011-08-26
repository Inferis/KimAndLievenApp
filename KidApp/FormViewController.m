//
//  FormViewController.m
//  KidApp
//
//  Created by Tom Adriaenssen on 11/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "FormViewController.h"
#import "TextFieldCell.h"
#import "DateController.h"
#import "SexController.h"

@implementation FormViewController

@synthesize tableView = _tableView;
@synthesize person = _person, backgroundImageView = _backgroundImageView;
@synthesize nameField = _nameField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization::Geboorteuur:Geslacht:Lengte:Gewicht
        data = [[NSArray arrayWithObjects:
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Naam van het kind", @"title", @"text", @"type", @"", @"data", nil], 
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Geboortedatum", @"title", @"date", @"type", @"", @"data", nil], 
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Geboorteuur", @"title", @"time", @"type", @"", @"data", nil], 
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Geslacht", @"title", @"sex", @"type", @"", @"data", nil], 
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Lengte", @"title", @"text", @"type", @"", @"data", nil], 
                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Gewicht", @"title", @"text", @"type", @"", @"data", nil], 
                nil] retain];
        currentlyEditing = NSNotFound;
        lastEdited = NSNotFound;
    }
    return self;
}

- (void)dealloc
{
    [_poController release];
    [data release];
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

- (NSIndexSet*)allIndexesExcept:(int)except {
    NSMutableIndexSet* indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 6)];
    if (except != NSNotFound) [indexes removeIndex:except];
    return indexes;
}


- (void)keyboardWillShow:(NSNotification*)notification {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UITableViewCell *cell = (UITableViewCell*)[[[keyWindow performSelector:@selector(firstResponder)] superview] superview];
    
    currentlyEditing = [_tableView indexPathForCell:cell].section;

    [_tableView deleteSections:[self allIndexesExcept:currentlyEditing] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    NSIndexSet* indexes = [self allIndexesExcept:currentlyEditing];
    
    lastEdited = currentlyEditing;
    currentlyEditing = NSNotFound;

    [self performSelector:@selector(hide2:) withObject:indexes afterDelay:0.01];
}

- (void)hide2:(NSIndexSet*)indexes {
    [_tableView beginUpdates];
    [_tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationFade];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

- (void)finishedEditing:(NSString *)content {
    NSLog(@"editing = %d --> %@", lastEdited, content);
    [[data objectAtIndex:lastEdited] setValue:content forKey:@"data"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return currentlyEditing == NSNotFound ? 6 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    section = currentlyEditing != NSNotFound ? currentlyEditing : section;
    NSString* title = [[data objectAtIndex:section] objectForKey:@"title"];

    UILabel* label = [[[UILabel alloc] initWithFrame:(CGRect) { 25, 0, tableView.frame.size.width, 44 }] autorelease];
    label.text = title;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor blackColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22]];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = currentlyEditing != NSNotFound ? currentlyEditing : indexPath.section;
    NSString* type = [[data objectAtIndex:section] objectForKey:@"type"];

    UITableViewCell *cell;
    if ([type isEqualToString:@"text"]) {
        static NSString *TextFieldCellIdentifier = @"TextFieldCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:TextFieldCellIdentifier];
        if (cell == nil) {
            cell = [[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextFieldCellIdentifier] autorelease];
        }
        ((TextFieldCell*)cell).delegate = self;

        [((TextFieldCell*)cell).field setText:[[data objectAtIndex:section] objectForKey:@"data"]];
    }
    else {
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22]];
        cell.textLabel.text = [[data objectAtIndex:section] objectForKey:@"data"];
    }

        
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (currentlyEditing != NSNotFound) return nil;
    
    indexPath = [[[data objectAtIndex:indexPath.section] valueForKey:@"type"] isEqualToString:@"text"] ? nil : indexPath;
    NSLog(@"will %@", indexPath);
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentlyEditing = indexPath.section;
    NSDictionary* row = [data objectAtIndex:indexPath.section];
    NSString* type = [row valueForKey:@"type"];
    
    [_poController dismissPopoverAnimated:YES];
    if ([type isEqualToString:@"date"]) {
        DateController* dateController = [[[DateController alloc] initWithDate:[row valueForKey:@"data"]] autorelease];
        dateController.delegate = self;
        _poController = [[UIPopoverController alloc] initWithContentViewController:dateController];
        _poController.popoverContentSize = [dateController popoverSize];
        _poController.delegate = self;
        [_poController presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:tableView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
    else if ([type isEqualToString:@"time"]) {
        DateController* dateController = [[[DateController alloc] initWithTime:[row valueForKey:@"data"]] autorelease];
        dateController.delegate = self;
        _poController = [[UIPopoverController alloc] initWithContentViewController:dateController];
        _poController.popoverContentSize = [dateController popoverSize];
        _poController.delegate = self;
        [_poController presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:tableView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
    else if ([type isEqualToString:@"sex"]) {
        SexController* sexController = [[[SexController alloc] initWithSex:[row valueForKey:@"data"]] autorelease];
        sexController.delegate = self;
        _poController = [[UIPopoverController alloc] initWithContentViewController:sexController];
        _poController.popoverContentSize = [sexController popoverSize];
        _poController.delegate = self;
        [_poController presentPopoverFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:tableView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [_poController release];
    _poController = nil;

    [_tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentlyEditing] animated:YES];
    currentlyEditing = NSNotFound;
}

- (void)dismissAndSave:(BOOL)save {
    DateController* dateController = (DateController*)_poController.contentViewController;
    
    if (save) {
        if (currentlyEditing == 1)
            [[data objectAtIndex:currentlyEditing] setValue:[dateController getDateValue] forKey:@"data"];
        else if (currentlyEditing == 2) 
            [[data objectAtIndex:currentlyEditing] setValue:[dateController getTimeValue] forKey:@"data"];
        [_tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentlyEditing] animated:YES];
    }
    
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:currentlyEditing];
    [_poController dismissPopoverAnimated:YES];

    currentlyEditing = NSNotFound;
    [_tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationFade];
}

- (void)dismissAndSave:(BOOL)save withValue:(NSString *)value {
    if (save) {
        [[data objectAtIndex:currentlyEditing] setValue:value forKey:@"data"];
        [_tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentlyEditing] animated:YES];
    }
    
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:currentlyEditing];
    [_poController dismissPopoverAnimated:YES];
    
    currentlyEditing = NSNotFound;
    [_tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationFade];
}

@end
