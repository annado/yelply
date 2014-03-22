//
//  Businesses.h
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Business;

@interface Businesses : NSObject
@property (nonatomic, strong) NSArray *data;
- (NSUInteger)count;
- (Business *)get:(NSUInteger)index;
@end
