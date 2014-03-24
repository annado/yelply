//
//  SearchResultsViewController.h
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"

@class Businesses;
@class Filters;

@interface SearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersSetDelegate>
@property (nonatomic, strong) Businesses *results;
@property (nonatomic, strong) Filters *filters;
@end
