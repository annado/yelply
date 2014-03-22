//
//  Filters.m
//  Yelply
//
//  Created by Anna Do on 3/22/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Filters.h"

@implementation Filters

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        _sort = @"0";
    }
    return self;
}

@end
