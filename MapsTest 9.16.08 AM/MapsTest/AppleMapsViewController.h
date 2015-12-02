//
//  AppleMapsViewController.h
//  MapsTest
//
//  Created by Eric  Gilbert on 11/13/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

#ifndef AppleMapsViewController_h
#define AppleMapsViewController_h


#endif /* AppleMapsViewController_h */


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AppleMapsViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


@end