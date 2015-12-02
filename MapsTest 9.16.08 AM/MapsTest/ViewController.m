//
//  ViewController.m
//  MapsTest
//
//  Created by Eric  Gilbert on 11/12/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;

@interface ViewController() <
GMSIndoorDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *objectLatitudeFloor1;
@property (nonatomic, strong) NSMutableArray *objectLongitudeFloor1;
@property (nonatomic, strong) NSMutableArray *objectTitleFloor1;
@property (nonatomic, strong) NSMutableArray *objectLatitudeFloor2;
@property (nonatomic, strong) NSMutableArray *objectLongitudeFloor2;
@property (nonatomic, strong) NSMutableArray *objectTitleFloor2;
@property (nonatomic, strong) NSMutableArray *objectLatitudeFloorLower;
@property (nonatomic, strong) NSMutableArray *objectLongitudeFloorLower;
@property (nonatomic, strong) NSMutableArray *objectTitleFloorLower;
@property (nonatomic, retain) NSMutableDictionary *objectDetailsDict;
@end


@implementation ViewController {
    GMSMapView *mapView_;
    UIPickerView *_levelPickerView;
    NSArray *_levels;
    CLLocationManager *locationManager_;
    GMSGroundOverlay *overlay_;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [locationManager_ requestWhenInUseAuthorization];
    
    self.objectLatitudeFloor1 = [[NSMutableArray alloc] init];
    self.objectLongitudeFloor1 = [[NSMutableArray alloc] init];
    self.objectTitleFloor1 = [[NSMutableArray alloc] init];
    self.objectLatitudeFloor2 = [[NSMutableArray alloc] init];
    self.objectLongitudeFloor2 = [[NSMutableArray alloc] init];
    self.objectTitleFloor2 = [[NSMutableArray alloc] init];
    self.objectLatitudeFloorLower = [[NSMutableArray alloc] init];
    self.objectLongitudeFloorLower = [[NSMutableArray alloc] init];
    self.objectTitleFloorLower = [[NSMutableArray alloc] init];
    self.objectDetailsDict = [[NSMutableDictionary alloc]init];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.8879
                                                            longitude:-77.0200
                                                                zoom:18];
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.myLocationButton = YES;
    mapView_.myLocationEnabled = YES;
    mapView_.indoorDisplay.delegate = self;
    
    // Creates a blank map but does not show markers
    //mapView_.mapType = kGMSTypeNone;
    [self setGroundOverlay];


    self.view = mapView_;
    [self retrieveJSONData];

}

-(void)retrieveJSONData{
    
    NSMutableArray *hold = [[NSMutableArray alloc]init];
    NSString *url = @"http://files.bluecadet.com/nasm/prototype_feed.json";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
                                                          URLWithString:url]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response
                                                         options:0 error:&error];
    NSMutableDictionary *json2 = [[NSMutableDictionary alloc]init];
    [json2 setValue:json forKey:@"response"];
    int count = [json count];
    
    for(int i = 0; i < count; i++){
        
        NSString *floor = [json2[@"response"][i][@"floor"] stringValue];
        
        if ([floor isEqualToString:@"1"]){
            [self.objectTitleFloor1 addObject:json2[@"response"][i][@"title"]];
            [self.objectLatitudeFloor1 addObject:json2[@"response"][i][@"location"][@"latitude"]];
            [self.objectLongitudeFloor1 addObject:json2[@"response"][i][@"location"][@"longitude"]];
        }
        else if ([floor isEqualToString:@"2"]){
            [self.objectTitleFloor2 addObject:json2[@"response"][i][@"title"]];
            [self.objectLatitudeFloor2 addObject:json2[@"response"][i][@"location"][@"latitude"]];
            [self.objectLongitudeFloor2 addObject:json2[@"response"][i][@"location"][@"longitude"]];
        }
        else if ([floor isEqualToString:@"-1"]){
            [self.objectTitleFloorLower addObject:json2[@"response"][i][@"title"]];
            [self.objectLatitudeFloorLower addObject:json2[@"response"][i][@"location"][@"latitude"]];
            [self.objectLongitudeFloorLower addObject:json2[@"response"][i][@"location"][@"longitude"]];
        }
        


        
    }

}

-(void)setMapsMarkerPointsFloor1{
    
   [mapView_ clear];
    [self setGroundOverlay];
    
    int count = [self.objectTitleFloor1 count];

    for (int i = 0;i<count;i++){
        NSString *lat = [self.objectLatitudeFloor1 objectAtIndex:i];
        NSString *lon = [self.objectLongitudeFloor1 objectAtIndex:i];
        NSString *title = [self.objectTitleFloor1 objectAtIndex:i];
        
        double lt=[lat doubleValue];
        double ln=[lon doubleValue];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.appearAnimation=YES;
        marker.position = CLLocationCoordinate2DMake(lt,ln);
        marker.title = title;
        marker.map = mapView_;
        mapView_.myLocationEnabled = YES;
        self.view = mapView_;
    }
    
    CLLocation *myLocation = mapView_.myLocation;
    double myLat = myLocation.coordinate.latitude;
    double myLong = myLocation.coordinate.longitude;
    NSLog(@"My lat: %f    My long:%f",myLat,myLong);
   
}

-(void)setMapsMarkerPointsFloor2{
    [mapView_ clear];
    
    [self setGroundOverlay];
    
    int count = [self.objectTitleFloor2 count];
    
    for (int i = 0;i<count;i++){
        NSString *lat = [self.objectLatitudeFloor2 objectAtIndex:i];
        NSString *lon = [self.objectLongitudeFloor2 objectAtIndex:i];
        NSString *title = [self.objectTitleFloor2 objectAtIndex:i];
        
        double lt=[lat doubleValue];
        double ln=[lon doubleValue];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.appearAnimation=YES;
        marker.position = CLLocationCoordinate2DMake(lt,ln);
        marker.title = title;
        marker.map = mapView_;
        mapView_.myLocationEnabled = YES;
        self.view = mapView_;
    }
    
    
}

- (void)didChangeActiveLevel:(GMSIndoorLevel *)level {
    // On level change, sync our level picker's selection to the IndoorDisplay.
    NSString *levelString = level.name;
    NSLog(@"level changed to %@", levelString);
    if([levelString isEqualToString:@"Level 1"]){
        [self setMapsMarkerPointsFloor1];
    }
    else if([levelString isEqualToString:@"2"]){
        [self setMapsMarkerPointsFloor2];
    }else if([levelString isEqualToString:@"-1"]){
        [mapView_ clear];
    }
    

    if (level == nil) {
        level = (id)[NSNull null];  // box nil to NSNull for use in NSArray
    }
    NSUInteger index = [_levels indexOfObject:level];
    if (index != NSNotFound) {
        NSInteger currentlySelectedLevel = [_levelPickerView selectedRowInComponent:0];
        if ((NSInteger)index != currentlySelectedLevel) {
            [_levelPickerView selectRow:index inComponent:0 animated:NO];
        }
    }
    mapView_.myLocationEnabled = YES;
}

-(void)setGroundOverlay{
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(38.887820, -77.021127);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(38.888444, -77.018032);
    
    GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                              coordinate:northEast];
    
    //    // Choose the midpoint of the coordinate to focus the camera on.
    CLLocationCoordinate2D nasm = GMSGeometryInterpolate(southWest, northEast, 0.5);
    //    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:newark
    //                                                               zoom:12
    //                                                            bearing:0
    //                                                       viewingAngle:45];
    //    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    // Add the ground overlay, centered in Newark, NJ
    GMSGroundOverlay *groundOverlay = [[GMSGroundOverlay alloc] init];
    groundOverlay.icon = [UIImage imageNamed:@"floor1PNG2.png"];
    groundOverlay.position = nasm;
    groundOverlay.bounds = overlayBounds;
    groundOverlay.map = mapView_;
    
    
    
}




@end