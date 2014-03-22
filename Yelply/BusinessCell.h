//
//  ResultCell.h
//  Yelply
//
//  Created by Anna Do on 3/20/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Business;

@interface BusinessCell : UITableViewCell
@property (nonatomic, strong) Business *business;
+ (NSInteger)displayHeightForBusiness:(Business *)business;
@end
