//
//  FilterCell.h
//  Yelply
//
//  Created by Anna Do on 3/26/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Filters;

@interface FilterCell : UITableViewCell
@property (nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Filters *filters;
@end

@protocol FilterCellDelegate <NSObject>
@optional
- (void)filterCell:(FilterCell *)filterCell onSwitch:(UISwitch *)switchView;
@end