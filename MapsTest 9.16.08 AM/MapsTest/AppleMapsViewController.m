//
//  AppleMapsViewController.m
//  MapsTest
//
//  Created by Eric  Gilbert on 11/13/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppleMapsViewController.h"
#import <MapKit/MapKit.h>


@interface AppleMapsViewController()

@end

@implementation AppleMapsViewController {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    //the center of the region we'll move the map to
    CLLocationCoordinate2D center;
    
    //38.888330, -77.017846
    center.latitude = 38.8865;
    center.longitude = -77.0200;
    
    //set up zoom level
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = .004f; //the zoom level in degrees
    zoom.longitudeDelta = .004f;//the zoom level in degrees
    
    //stores the region the map will be showing
    MKCoordinateRegion myRegion;
    myRegion.center = center;//the location
    myRegion.span = zoom;//set zoom level
    
    
    //programmatically create a map that fits the screen
    CGRect screen = [[UIScreen mainScreen] bounds];
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:screen ];
    
    //set the map location/region
    [self.mapView setRegion:myRegion animated:YES];
    
    self.mapView.mapType = MKMapTypeStandard;
   // [self.view addSubview:mapView];
    
    //self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.delegate = self;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

@end