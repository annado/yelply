//
//  Filters.m
//  Yelply
//
//  Created by Anna Do on 3/22/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Filters.h"

@interface Filters ()
@end

@implementation Filters

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];

        _sortOptions = @[@"Best matched", @"Distance", @"Highest Rated"];
        _sort = 0;

        _radiusOptions = @[@100, @200, @500, @1000, @10000];
        _radius = 4;

        _sectionTitles = @[@"Sort", @"Distance", @"Deals", @"Category"];
        _offeringDeals = false;
        NSDictionary *categoryDict = @{@"Active Life": @"active",
                        @"Arts & Entertainment" : @"arts",
                        @"Automotive" : @"auto",
                        @"Beauty & Spas" : @"beautysvc",
                        @"Education" : @"education",
                        @"Event Planning & Services" : @"eventservices",
                        @"Financial Services" : @"financialservices",
                        @"Food" : @"food",
                        @"Health & Medical" : @"health",
                        @"Home Services" : @"homeservices",
                        @"Hotels & Travel" : @"hotelstravel",
                        @"Local Services" : @"localservices",
                        @"Nightlife" : @"nightlife",
                        @"Pets" : @"pets",
                        @"Professional Services" : @"professional",
                        @"Public Services & Government" : @"publicservicesgovt",
                        @"Real Estate" : @"realestate",
                        @"Restaurants" : @"restaurants",
                        @"Shopping" : @"shopping"
                        };
        _categories = [[categoryDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//        NSMutableDictionary *selectedCategories = [[NSMutableDictionary alloc] initWithCapacity:[categoryDict count]];
//        [selectedCategories addEntriesFromDictionary:categoryDict];
        
    }
    return self;
}

- (NSString *)getRadiusFilter {
    
    return [_radiusOptions objectAtIndex:_radius];
}

- (NSString *)getSortFilter {
    return [NSString stringWithFormat:@"%ld", (long)_sort];
}

- (NSDictionary *)getParametersWithTerm:(NSString *)term {
    return @{
      @"term" : term,
      @"sort" : [NSString stringWithFormat:@"%ld", (long)_sort],
      @"location" : @"San Francisco",
      @"deals_filter" : _offeringDeals ? @"true" : @"false",
      @"radius_filter" : [self getRadiusFilter]
      };
}

@end
