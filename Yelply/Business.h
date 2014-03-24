//
//  Business.h
//  Yelply
//
//  Created by Anna Do on 3/21/14.
//  Copyright (c) 2014 Anna Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject
- (id)initWithDictionary:(NSDictionary *)dict;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSURL *ratingImageURL;
@property (nonatomic, assign) NSString *reviews;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *category;
@end
