//
//  ViewController.h
//  Grip
//
//  Created by luke anfang on 11/22/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@import Firebase;
@import FirebaseAuth;
#import "MapPin.h"
//Needs a location manager delegate and a mapView
@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    MKMapView *mapView;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

