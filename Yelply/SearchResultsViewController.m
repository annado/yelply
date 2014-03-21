//
//  SearchResultsViewController.m
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "ResultCell.h"

@interface SearchResultsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil] forCellReuseIdentifier:@"ResultCell"];

}

#pragma mark - UITableViewController methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultCell";
    ResultCell *cell = (ResultCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    MovieViewController *movieController = [[MovieViewController alloc] initWithMovie:movie];
//    
//    [[self navigationController] pushViewController:movieController animated:YES];
}


@end
