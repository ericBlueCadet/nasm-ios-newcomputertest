//
//  NearMeTableViewController.h
//  MapsTest
//
//  Created by Eric  Gilbert on 11/16/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

#ifndef NearMeTableViewController_h
#define NearMeTableViewController_h


#endif /* NearMeTableViewController_h */

#import <UIKit/UIKit.h>
@interface NearMeTableViewController : UITableViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentController;

@end