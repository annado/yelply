//
//  FiltersViewController.m
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "FiltersViewController.h"
#import "Filters.h"

static NSInteger SectionSort = 0;
static NSInteger SectionRadius = 1;
static NSInteger SectionDeals = 2;
static NSInteger SectionCategories = 3;

@interface FiltersViewController ()
@property (nonatomic, assign) BOOL sortExpanded;
@property (nonatomic, assign) BOOL radiusExpanded;
@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
        self.sortExpanded = NO;
        self.radiusExpanded = NO;
        
        // Configure the Search button
        UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButton:)];
        self.navigationItem.rightBarButtonItem = searchButton;
        
        // Configure the Cancel button
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Customize switches
    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Filter change events
- (void)onCancel:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSearchButton:(UIBarButtonItem *)button
{
    [self filtersUpdated];
}

- (void)onSwitchDeal:(UISwitch *)switchView
{
    _filters.offeringDeals = switchView.on;
}

- (void)filtersUpdated
{
    [self.delegate filtersViewController:self didSetFilters:_filters];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == SectionCategories) {
        return [_filters.categories count];
    }
    else if (section == SectionSort) {
        return (self.sortExpanded) ? 3 : 1;
    } else if (section == SectionRadius) {
        return (self.radiusExpanded) ? 3 : 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterCell";
    static NSString *DealsCellIdentifier = @"DealsCell";
    static NSString *CategoryCellIdentifier = @"CategoryCell";
    
    UITableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.section == SectionSort) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [_filters.sortDictionary objectForKey:_filters.sort];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
        arrowView.image = [arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
        cell.accessoryView = arrowView;
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = @"Radius...";
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
        arrowView.image = [arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
        cell.accessoryView = arrowView;
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:DealsCellIdentifier];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DealsCellIdentifier];
        }
        [self setDealsCell:cell];
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
        }
        cell.textLabel.text = [_filters.categories objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

//- (UITableView *)cellDequeuedWithIdentifier:(NSString *)identifier
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (nil == cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SectionSort) {
        self.sortExpanded = !self.sortExpanded;
        [tableView reloadData];
    } else if (indexPath.section == SectionRadius) {
        self.radiusExpanded = !self.radiusExpanded;
        [tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_filters.sectionTitles objectAtIndex:section];
}

#pragma mark - Setup cell views
- (void)setDealsCell:(UITableViewCell *)cell
{
    cell.textLabel.text = @"Offering a Deal";
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.on = _filters.offeringDeals;
    [switchView addTarget:self action:@selector(onSwitchDeal:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = switchView;
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end

