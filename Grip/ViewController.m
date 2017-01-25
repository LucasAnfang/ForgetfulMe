//
//  ViewController.m
//  Grip
//
//  Created by luke anfang on 11/22/16.
//  Copyright © 2016 luke anfang. All rights reserved.
////lanfang@usc.edu

#import "ViewController.h"
#import "LocationDetailsModel.h"
#import "AddLocationDetailViewController.h"
@interface ViewController ()
//locationDetailsModel is the shared model
@property (strong, nonatomic) LocationDetailsModel* locationDetailsModel;
@property CLLocation *myLocation;
@property NSString *latitudeVal;
@property NSString *longitudeVal;
@end

@implementation ViewController //synthesize the location manager and mapview
@synthesize locationManager = _locationManager;
@synthesize mapView = _mapView;


- (IBAction)AddNewLocationDetail:(id)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //get shared model
    _locationDetailsModel = [LocationDetailsModel sharedModel];
    //initialize location manager, set its accuracy, set the delagate to self, and request location tracking
    //This required privacy strings to be added to the info plist
    self.locationManager = [[CLLocationManager alloc] init];
    //[[self.myLocation alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = kCLLOcati
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    //start gettting location data
    [self.locationManager startUpdatingLocation];
}
-(void)viewDidAppear:(BOOL)animated {
    //when main view appears refresh must be called and the location manager must get the new coordinate
    [self refreshMapView];
    [self.locationManager startUpdatingLocation];
}

- (void)refreshMapView{
    //Clear the annotations from the mapView and add all the location details from the model as annotations to the map (done in load in location details
    NSMutableArray * annotationsToRemove = [ self.mapView.annotations mutableCopy ] ;
    [ annotationsToRemove removeObject:self.mapView.userLocation ] ;
    [ self.mapView removeAnnotations:annotationsToRemove ] ;
    //[self.locationManager stopUpdatingLocation];
    //NSLog(@"Street: %@", [self getAddressFromLatLon:newLocation.coordinate.latitude withLongitude:newLocation.coordinate.longitude]);
    [self loadInLocationDetails];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //this is used to get the updates of location
    //set the property values of users lat and long
    self.latitudeVal = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    self.longitudeVal = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    _myLocation = newLocation; //this was not used but still interesting might work with later
    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    region.center.latitude = newLocation.coordinate.latitude;
    region.center.longitude = newLocation.coordinate.longitude; //set a region around the user to get the bounds of the mapKit view
    region.span.latitudeDelta = 0.01f;
    region.span.longitudeDelta = 0.01f;
    [self.mapView setRegion:region animated:YES];
    //add location details to mapview
    [self refreshMapView];
    //stop updating location to allow user to click on pins in map without the message disapearing on updates
    [self.locationManager stopUpdatingLocation];
    
}

-(void) loadInLocationDetails{
    NSLog(@"Loading in pins");// interate through location details
    for(int i = 0; i < [self.locationDetailsModel numberOfLocationDetails]; i++){
        //MapPin *annotation = [[MapPin alloc] init];
        LocationDetail *locDetail = [self.locationDetailsModel LocationDetailAtIndex:i];
        //annotation.title = locDetail.title;
        NSLog(@"Description %@ :: lat %@ :: long %@", [self.locationDetailsModel LocationDetailAtIndex:i].locDescription,[self.locationDetailsModel LocationDetailAtIndex:i].latitude,[self.locationDetailsModel LocationDetailAtIndex:i].longitude);
        //get the location stored in the location detail using its stored lat and long
        CLLocation *theLocation = [[CLLocation alloc]  initWithLatitude:[locDetail.latitude floatValue] longitude:[locDetail.longitude floatValue]];
        //annotation.coordinate = [theLocation coordinate];
        //create the annotation and set its title. add to the mapView
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:[theLocation coordinate]];
        [annotation setTitle:locDetail.title]; //You can set the subtitle too
        [self.mapView addAnnotation:annotation];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self.locationManager startUpdatingLocation];
    if([segue.identifier isEqualToString:@"MainToAdd"])
    {
        //Need a completion handler for adding new location details This is used when the button is pressed to add a new detain and is essential for the add cencel functionality to work later cleanly
        AddLocationDetailViewController *aldvc = segue.destinationViewController;
        aldvc.completionHandler = ^(NSString *title, NSString *description){
            if (title != nil && description != nil) {
                NSLog(@"%@", description);
                [self.locationDetailsModel insertWithTitle:title Description:description Latitude:_latitudeVal Longitude:_longitudeVal];
            }
            //dismiss the VC
        [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
}



@end
