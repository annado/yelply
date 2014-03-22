//
//  SearchResultsViewController.m
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

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

@end

@implementation SearchResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Yelply";
        
        // Configure the filter button
        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FilterIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton:)];
        self.navigationItem.rightBarButtonItem = filterButton;
        
        _filters = [[Filters alloc] init];
        
        self.results = [[Businesses alloc] init];
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            self.results.data = response[@"businesses"];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

}

#pragma mark - FiltersSetDelegate methods
- (void)filtersViewController:(FiltersViewController *)filtersViewController
                didSetFilters:(Filters *)filters
{
    NSLog(@"Updated filters!");

    _filters = filtersViewController.filters;
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

@end
