//
//  Filters.h
//  Yelply
//
//  Created by Anna Do on 3/22/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, assign) BOOL offeringDeals;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSArray *sortOptions;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, strong) NSArray *radiusOptions;
- (NSDictionary *)getParametersWithTerm:(NSString *)term;
- (NSString *)labelForRadiusAtIndex:(NSInteger)index;
@end
