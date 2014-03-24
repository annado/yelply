//
//  Business.m
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _name = dict[@"name"];
        _location = [self getAddressFromDict:dict];
        _reviews = dict[@"review_count"];
        _imageURL = [NSURL URLWithString:dict[@"image_url"]];
        _ratingImageURL = [NSURL URLWithString:dict[@"rating_img_url_small"]];
        _category = [self getCategoryFromDict:dict];
    }
    return self;
}

- (NSString *)getAddressFromDict:(NSDictionary *)dict
{
    NSArray *neighborhoods = dict[@"location"][@"neighborhoods"];
    NSArray *addresses = dict[@"location"][@"display_address"];
    NSString *address2 = @"";
    if ([neighborhoods count] > 0) {
        address2 = neighborhoods[0];
    } else {
        address2 = dict[@"location"][@"city"];
    }
    return [NSString stringWithFormat:@"%@, %@", addresses[0], address2];
}

- (NSString *)getCategoryFromDict:(NSDictionary *)dict
{
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    for (NSArray *object in dict[@"categories"]) {
        [categories addObject:object[0]];
    }
    return [categories componentsJoinedByString:@", "];
}

@end
