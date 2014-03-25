//
//  Businesses.m
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Businesses.h"
#import "Business.h"

@implementation Businesses

- (id)init
{
    self = [super init];
    if (self) {
        _data = [[NSArray alloc] init];
    }
    return self;
}

- (NSUInteger)count
{
    return [_data count];
}

- (Business *)get:(NSUInteger)index
{
    if (index < [self count]) {
        NSDictionary *dict = _data[index];
        return [[Business alloc] initWithDictionary:dict];
    } else {
        return nil;
    }
}

@end
