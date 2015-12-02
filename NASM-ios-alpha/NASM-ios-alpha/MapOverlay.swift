//
//  MapOverlay.swift
//  NASM-ios-alpha
//
//  Created by Eric  Gilbert on 11/20/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(museum: Museum) {
        boundingMapRect = museum.overlayBoundingMapRect
        coordinate = museum.midCoordinate
    }
}