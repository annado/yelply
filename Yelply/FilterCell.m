//
//  FilterCell.m
//  Yelply
//
//  Created by Anna Do on 3/26/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "FilterCell.h"
#import "Filters.h"

@interface FilterCell ()
@property (weak, nonatomic) IBOutlet UISwitch *onSwitch;
@end

@implementation FilterCell

- (void)awakeFromNib
{
    // Initialization code
    [self.onSwitch addTarget:self action:@selector(onSwitch:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFilters:(Filters *)filters
{
    _filters = filters;
    self.onSwitch.on = _filters.offeringDeals;
    self.nameLabel.text = @"Offering a Deal";
}

- (void)onSwitch:(UISwitch *)onSwitch
{
    // TODO check that the delegate implements this protocol
    [self.delegate filterCell:self onSwitch:onSwitch];
}

@end
