//
//  LocationDetail.m
//  Grip
//
//  Created by luke anfang on 12/6/16.
//  Copyright © 2016 luke anfang. All rights reserved.
//lanfang@usc.edu


#import "LocationDetail.h"
@interface LocationDetail()

@end

@implementation LocationDetail
//location details need title, description,latitude and longitude
//These are all strings becuase they take up less space on storage also easier to work with for this
- (instancetype) initWithTitle: (NSString *) title
                           Description: (NSString *) description
                           Latitude: (NSString *) latitude
                           Longitude: (NSString *) longitude{
    self = [super init]; //set values
    _title = title;
    _locDescription = description;
    _latitude = latitude;
    _longitude = longitude;
    return self;
}


- (instancetype) initWithDictionary: (NSDictionary *) locDetail { //this is needed for plist storage because it cant store straight location details
    self = [super init];
    if (self) {
        _title = [locDetail valueForKey: kTitleKey]; //set with key vals
        _locDescription = [locDetail valueForKey: kDescriptionKey];
        _latitude = [locDetail valueForKey: kLatidudeKey];
        _longitude = [locDetail valueForKey: kLongitudeKey];
    }
    return self;
}

- (NSDictionary *) dictionary { //setup for dictionary of key to val
    NSDictionary *card = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.title, kTitleKey,
                          self.locDescription, kDescriptionKey,
                          self.latitude, kLatidudeKey,
                          self.longitude, kLongitudeKey,
                          nil];
    return card;
}

@end
