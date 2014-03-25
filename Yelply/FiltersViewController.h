//
//  FiltersViewController.h
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Filters;

@interface FiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Filters *filters;
@property (nonatomic, weak) id delegate; // TODO: should be id<FiltersSetDelegate>
@end

@protocol FiltersSetDelegate <NSObject>
- (void)filtersViewController:(FiltersViewController *)filtersViewController
                didSetFilters:(Filters *)filters;
@end