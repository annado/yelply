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
        _location = dict[@"location"][@"address"][0];
        _reviews = dict[@"review_count"];
        _imageURL = [NSURL URLWithString:dict[@"image_url"]];
        _ratingImageURL = [NSURL URLWithString:dict[@"rating_img_url_small"]];
    }
    return self;
}

@end
