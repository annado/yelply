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
    
    // Setup TableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    [self.delegate filtersViewController:self didSetFilters:nil];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == SectionCategories) {
        return [_filters.categories count];
    } else if (section == SectionSort) {
        return (self.sortExpanded) ? (1 + [_filters.sortOptions count]) : 1;
    } else if (section == SectionRadius) {
        return (self.radiusExpanded) ? (1 + [_filters.radiusOptions count]) : 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterValueCell";
    static NSString *DropdownCellIdentifier = @"FilterDropdownCell";
    static NSString *SwitchCellIdentifier = @"FilterSwitchCell";
    
    UITableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.section == SectionSort) {
        if (indexPath.row == 0) {
            cell = [self dequeueReusableCellWithIdentifier:DropdownCellIdentifier];
            cell.textLabel.text = [_filters.sortOptions objectAtIndex:_filters.sort];
            [self addMenuAccessoryView:cell];
        } else {
            cell = [self dequeueReusableCellWithIdentifier:CellIdentifier];
            NSInteger index = indexPath.row - 1;
            cell.textLabel.text = [_filters.sortOptions objectAtIndex:index];
            if (_filters.sort == index) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else if (indexPath.section == SectionRadius) {
        if (indexPath.row == 0) {
            cell = [self dequeueReusableCellWithIdentifier:DropdownCellIdentifier];
            cell.textLabel.text = [_filters labelForRadiusAtIndex:_filters.radius];
            [self addMenuAccessoryView:cell];
        } else {
            cell = [self dequeueReusableCellWithIdentifier:CellIdentifier];
            NSInteger index = indexPath.row - 1;
            cell.textLabel.text = [_filters labelForRadiusAtIndex:index];
            if (_filters.radius == index) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else if (indexPath.section == SectionDeals) {
        cell = [self dequeueReusableCellWithIdentifier:SwitchCellIdentifier];
        cell.textLabel.text = @"Offering a Deal";
        [self addSwitchAccessoryView:cell];
    } else if (indexPath.section == SectionCategories) {
        cell = [self dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.textLabel.text = [_filters.categories objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == SectionSort) {
        if (indexPath.row > 0) { // not the header row
            cell.accessoryType = (cell.accessoryType == UITableViewCellAccessoryNone) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }

        if (indexPath.row > 0) {
            _filters.sort = indexPath.row - 1;
        }
        self.sortExpanded = !self.sortExpanded;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionSort] withRowAnimation:UITableViewRowAnimationFade];

    } else if (indexPath.section == SectionRadius) {
        if (indexPath.row > 0) { // not the header row
            cell.accessoryType = (cell.accessoryType == UITableViewCellAccessoryNone) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
        self.radiusExpanded = !self.radiusExpanded;
        if (indexPath.row > 0) {
            _filters.radius = indexPath.row - 1;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:SectionRadius] withRowAnimation:UITableViewRowAnimationFade];
    } else if (indexPath.section == SectionCategories) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        // TODO: implement category selection
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_filters.sectionTitles objectAtIndex:section];
}

#pragma mark - Setup cell views
- (void)addSwitchAccessoryView:(UITableViewCell *)cell
{
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.on = _filters.offeringDeals;
    [switchView addTarget:self action:@selector(onSwitchDeal:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = switchView;
}

- (void)addMenuAccessoryView:(UITableViewCell *)cell
{
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
    arrowView.image = [arrowView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
    cell.accessoryView = arrowView;
}

@end

