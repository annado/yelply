//
//  SearchResultsViewController.m
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import "SearchResultsViewController.h"
#import "FiltersViewController.h"
#import "BusinessCell.h"
#import "YelpClient.h"
#import "Businesses.h"
#import "Filters.h"

NSString * const kYelpConsumerKey = @"Shz-PUyzD8l3vb6CioUi0w";
NSString * const kYelpConsumerSecret = @"xyQsjADqZTLkMdFmA1aFg7oFp8k";
NSString * const kYelpToken = @"JnN_owWaTAKTfOlZgk7uV6X1eXBige-h";
NSString * const kYelpTokenSecret = @"_Pq3Gdo5rv5laJMWGFkcqBGBK94";

@interface SearchResultsViewController ()
@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *searchTerm;
@end

@implementation SearchResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Yelply";
        self.searchTerm = @"Thai";
        
        // Configure the filter button
        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FilterIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton:)];
        self.navigationItem.rightBarButtonItem = filterButton;
        
        // Configure title
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.delegate = self;
        searchBar.text = self.searchTerm;

        //        UIView *iv = [[UIView alloc] initWithFrame:CGRectMake(0,0,32,32)];
        self.navigationItem.titleView = searchBar;
        
        _filters = [[Filters alloc] init];
        
        self.results = [[Businesses alloc] init];
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        
    }
    return self;
}

- (void)load
{
    NSDictionary *parameters = @{
                                 @"term" : self.searchTerm,
                                 @"sort" : _filters.sort,
                                 @"location" : @"San Francisco"
                                 };
    
    [self.client searchWithParameters:parameters success:^(AFHTTPRequestOperation *operation, id response) {
        self.results.data = response[@"businesses"];
        [SVProgressHUD dismiss];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        [SVProgressHUD dismiss];
        [self.refreshControl endRefreshing];
    }];
}

- (void)search
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self load];
}

- (void)onFilterButton:(UIBarButtonItem *)button
{
    FiltersViewController *filtersViewController = [[FiltersViewController alloc] init];
    filtersViewController.filters = _filters;
    filtersViewController.delegate = self;
    [self.navigationController pushViewController:filtersViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup tableview
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    // start search
    [self load];

    // add RefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(search)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
}

#pragma mark - FiltersSetDelegate methods
- (void)filtersViewController:(FiltersViewController *)filtersViewController
                didSetFilters:(Filters *)filters
{
    NSLog(@"Updated filters!");

    _filters = filtersViewController.filters;
    [self search];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewController methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusinessCell";
    BusinessCell *cell = (BusinessCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.business = [_results get:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    MovieViewController *movieController = [[MovieViewController alloc] initWithMovie:movie];
//    
//    [[self navigationController] pushViewController:movieController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Business *business = [_results get:indexPath.row];
    return [BusinessCell displayHeightForBusiness:business];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
//    self.searchTerm = searchBar.text;
//    [self search];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked");
    [searchBar resignFirstResponder];
    self.searchTerm = searchBar.text;
    [self search];
}

@end
