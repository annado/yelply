//
//  ToggleMenuCell.m
//  Yelply
//
//  Created by Anna Do on 3/26/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "ToggleMenuCell.h"

@implementation ToggleMenuCell

- (void)awakeFromNib
{
    // Initialization code
    self.arrowView.tintColor = [UIColor colorWithRed:(196/255.0f) green:(18/255.0f) blue:0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuWithOptions:(NSArray *)options selected:(NSInteger)selected
{
    _menuOptions = options;
    _selectedOption = selected;
    _nameLabel.text = _menuOptions[_selectedOption];
}

@end
