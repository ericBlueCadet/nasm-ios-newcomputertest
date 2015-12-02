#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "IndoorViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation IndoorViewController {
  GMSMapView *mapView_;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.8879
                                                          longitude:-77.0200
                                                               zoom:18];

  mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  mapView_.settings.myLocationButton = YES;
//    // Listen to the myLocation property of GMSMapView.
//    [mapView_ addObserver:self
//               forKeyPath:@"myLocation"
//                  options:NSKeyValueObservingOptionNew
//                  context:NULL];
//    
//    self.view = mapView_;
//    
//    // Ask for My Location data after the map has already been added to the UI.
//    dispatch_async(dispatch_get_main_queue(), ^{
//    mapView_.myLocationEnabled = YES;
//    });
    
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
}





@end
