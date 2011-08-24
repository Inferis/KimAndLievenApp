//
//  FormViewController.m
//  KidApp
//
//  Created by Tom Adriaenssen on 11/08/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "FormViewController.h"


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
    
    //self.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg-%@.jpg", self.person]];
    
    
//    UIFont *fieldFont = [[UIFont fontWithName:@"Chauncy Deluxxe" size:55] autorelease];
//    _nameField.font = fieldFont;
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];

    UIView* view = [[_tableView subviews] objectAtIndex:0];
    view.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated  {
    for (UIView* view in [_tableView subviews]) {
        if ([[[view class] description] isEqualToString:@"UITableHeaderFooterView"]) {
            UILabel* label = [[view subviews] objectAtIndex:0];
            [label setTextColor:[UIColor whiteColor]];
            [label setShadowColor:[UIColor blackColor]];
            [label setFont:[UIFont boldSystemFontOfSize:22]];
            label.frame = (CGRect) { label.frame.origin, label.frame.size.width + 50, label.frame.size.height };
        }
    }

    [super viewDidAppear:animated];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[@"Naam van het kind:Geboortedatum:Geboorteuur:Geslacht:Lengte:Gewicht" componentsSeparatedByString:@":"] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Lieven";
        cell.imageView.image = [UIImage imageNamed:@"icon-lieven.png"];
    }
    else {
        cell.textLabel.text = @"Kim";
        cell.imageView.image = [UIImage imageNamed:@"icon-kim.png"];
    }
    
    return cell;
}


@end
