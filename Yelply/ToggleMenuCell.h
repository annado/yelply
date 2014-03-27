//
//  ToggleMenuCell.h
//  Yelply
//
//  Created by Anna Do on 3/26/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToggleMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
@property (nonatomic, strong) NSArray *menuOptions;
@property (nonatomic, assign) NSInteger selectedOption;
- (void)setMenuWithOptions:(NSArray *)options selected:(NSInteger)selected;
@end
