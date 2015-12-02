//
//  NearMeTableViewController.m
//  MapsTest
//
//  Created by Eric  Gilbert on 11/16/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NearMeFloor2TableViewController.h"
#import "NearMeFloor2TableViewCell.h"



//

@interface NearMeFloor2TableViewController ()

@property (nonatomic, strong) NSMutableArray *objectLatitudeFloor1;
@property (nonatomic, strong) NSMutableArray *objectLongitudeFloor1;
@property (nonatomic, strong) NSMutableArray *objectTitleFloor1;
@property (nonatomic, strong) NSMutableArray *objectLatitudeFloor2;
@property (nonatomic, strong) NSMutableArray *objectLongitudeFloor2;
@property (nonatomic, strong) NSMutableArray *objectTitleFloor2;
@property (nonatomic, strong) NSArray *sortedByClosestFloor1;
@property (nonatomic, strong) NSArray *sortedByClosestFloor2;
@property (nonatomic) NSInteger selectedSegmentIndex;
@property (nonatomic, strong) NSMutableDictionary *objectTitleAndDistanceFloor1;
@property (nonatomic, strong) NSMutableDictionary *objectTitleAndDistanceFloor2;
@property (nonatomic) NSInteger objectCountFloor1;
@property (nonatomic) NSInteger objectCountFloor2;
@end

@implementation NearMeFloor2TableViewController{
    CLLocationManager *locationManager;
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.segmentController.selectedSegmentIndex = 0;
//    //    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"One", @"Two", nil]];
//    //   // segmentedControl.frame = CGRectMake(50, 0, 220, 100);
//    //     self.tableView.tableHeaderView = segmentedControl;
//    [self.segmentController addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:segmentedControl];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    
    self.objectLatitudeFloor1 = [[NSMutableArray alloc] init];
    self.objectLongitudeFloor1 = [[NSMutableArray alloc] init];
    self.objectTitleFloor1 = [[NSMutableArray alloc] init];
    self.objectLatitudeFloor2 = [[NSMutableArray alloc] init];
    self.objectLongitudeFloor2 = [[NSMutableArray alloc] init];
    self.objectTitleFloor2 = [[NSMutableArray alloc] init];
    //self.sortedByClosestFloor1 = [[NSArray alloc] init];
    //self.sortedByClosestFloor2 = [[NSArray alloc] init];
    self.objectTitleAndDistanceFloor1 = [[NSMutableDictionary alloc] init];
    self.objectTitleAndDistanceFloor2 = [[NSMutableDictionary alloc] init];
    [self retrieveJSONData];
    
    NSLog(@"%@", [self deviceLocation]);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[self retrieveJSONData];
    return self.objectCountFloor2;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NearMeFloor2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearMeFloor2Cell" forIndexPath:indexPath];

    cell.nameLabel.text = [self.sortedByClosestFloor2 objectAtIndex:indexPath.row];
    
    
    //    cell.reviewNameLabel.text = [self.venueReviewNames objectAtIndex:indexPath.row];
    //    cell.contentView.backgroundColor = [UIColor clearColor];
    //    cell.backgroundColor = [UIColor clearColor];
    //
    return cell;
    
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
        
        
    }
    
    self.objectCountFloor1 = [self.objectTitleFloor1 count];
    self.objectCountFloor2 = [self.objectTitleFloor2 count];
    [self sortObjectsByDistance];
}

-(void)sortObjectsByDistance{
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    for(int i = 0; i< self.objectCountFloor1; i++){
        
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[self.objectLatitudeFloor1 objectAtIndex:i ]doubleValue] longitude:[[self.objectLongitudeFloor1 objectAtIndex:i ]doubleValue]];
        
        CLLocationDistance distance = [locA distanceFromLocation:locB];
        
        NSNumber* num = [NSNumber numberWithInt:distance];
        
        [self.objectTitleAndDistanceFloor1 setObject:num forKey:[self.objectTitleFloor1 objectAtIndex:i]];
        // NSLog(@"distance: %@  count: %d",num,i);
    }
    
    self.sortedByClosestFloor1 = [self.objectTitleAndDistanceFloor1 keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    
    for(int i = 0; i< self.objectCountFloor2; i++){
        
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[self.objectLatitudeFloor2 objectAtIndex:i ]doubleValue] longitude:[[self.objectLongitudeFloor2 objectAtIndex:i ]doubleValue]];
        
        CLLocationDistance distance = [locA distanceFromLocation:locB];
        
        NSNumber* num = [NSNumber numberWithInt:distance];
        
        [self.objectTitleAndDistanceFloor2 setObject:num forKey:[self.objectTitleFloor2 objectAtIndex:i]];
        // NSLog(@"distance: %@  count: %d",num,i);
    }
    
    self.sortedByClosestFloor2 = [self.objectTitleAndDistanceFloor2 keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
}



@end
