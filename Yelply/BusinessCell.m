//
//  ResultCell.m
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "BusinessCell.h"
#import "Business.h"

@interface BusinessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImageView;
@end

@implementation BusinessCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setBusiness:(Business *)business
{
    _business = business;
    self.nameLabel.text = _business.name;
    self.locationLabel.text = _business.location;
    self.reviewsLabel.text = [NSString stringWithFormat:@"%@ Reviews", _business.reviews];

    [self.avatarImageView setImageWithURL:_business.imageURL];
    [self.ratingsImageView setImageWithURL:_business.ratingImageURL];
    self.categoryLabel.text = _business.category;
}

static NSInteger NameLabelMaxWidth = 183;
static NSInteger ReviewsLabelHeight = 15;
static NSInteger LocationLabelHeight = 15;
static NSInteger CategoryLabelHeight = 15;
static NSInteger CellVerticalPadding = 24;

+ (NSInteger)displayHeightForBusiness:(Business *)business
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
    NSInteger nameHeight = [business.name boundingRectWithSize:CGSizeMake(NameLabelMaxWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;

    NSInteger height = nameHeight + ReviewsLabelHeight + LocationLabelHeight + CategoryLabelHeight + CellVerticalPadding;
    return (height > 91) ? height : 91;
}

@end
