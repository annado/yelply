//
//  Filters.m
//  Yelply
//
//  Created by Anna Do on 3/22/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import "Filters.h"

@interface Filters ()
@property (nonatomic, strong) NSArray *sortOptions;
@end

@implementation Filters

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];

        _sortDictionary = @{ @"0" : @"Best matched",
                                   @"1" : @"Distance",
                                   @"2" : @"Highest Rated"
                                   };
        _sort = @"0";
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

@end
