//
//  LocationDetail.h
//  Grip
//
//  Created by luke anfang on 12/6/16.
//  Copyright © 2016 luke anfang. All rights reserved.
//lanfang

#import <Foundation/Foundation.h>
//location details need title, description,latitude and longitude keys
static NSString * const kTitleKey = @"title";
static NSString * const kDescriptionKey = @"description";
static NSString * const kLatidudeKey = @"lat";
static NSString * const kLongitudeKey = @"long";

@interface LocationDetail : NSObject
//location details need title, description,latitude and longitude
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* locDescription;
@property (nonatomic, readonly) NSString* latitude;
@property (nonatomic, readonly) NSString* longitude;

//initializer methods
- (instancetype) initWithTitle: (NSString *) title
                   Description: (NSString *) description
                      Latitude: (NSString *) latitude
                     Longitude: (NSString *) longitude;

- (instancetype) initWithDictionary: (NSDictionary *) locDetail;
- (NSDictionary *) dictionary;

@end

