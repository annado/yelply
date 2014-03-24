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
        return (self.sortExpanded) ? [_filters.sortOptions count] : 1;
    } else if (section == SectionRadius) {
        return (self.radiusExpanded) ? [_filters.radiusOptions count] : 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterCell";
    static NSString *FilterCellIdentifier = @"FilterHeaderCell";
    static NSString *DealsCellIdentifier = @"DealsCell";
    static NSString *CategoryCellIdentifier = @"CategoryCell";
    
    UITableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.section == SectionSort) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:FilterCellIdentifier];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FilterCellIdentifier];
            }
            
            cell.textLabel.text = [_filters.sortOptions objectAtIndex:_filters.sort];
            UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
            arrowView.image = [arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
            cell.accessoryView = arrowView;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            NSInteger index = indexPath.row - 1;
            cell.textLabel.text = [_filters.sortOptions objectAtIndex:index];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {

            cell = [tableView dequeueReusableCellWithIdentifier:FilterCellIdentifier];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FilterCellIdentifier];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@ m", [_filters.radiusOptions objectAtIndex:_filters.radius]];
            UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
            arrowView.image = [arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
            cell.accessoryView = arrowView;
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (nil == cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            NSInteger index = indexPath.row - 1;
            cell.textLabel.text = [NSString stringWithFormat:@"%@ m", [_filters.radiusOptions objectAtIndex:index]];
        }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SectionSort) {
        self.sortExpanded = !self.sortExpanded;
        if (indexPath.row > 0) {
            _filters.sort = indexPath.row - 1;
        }
        [tableView reloadData];
    } else if (indexPath.section == SectionRadius) {
        self.radiusExpanded = !self.radiusExpanded;
        if (indexPath.row > 0) {
            _filters.radius = indexPath.row - 1;
        }
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

@end

