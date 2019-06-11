//
//  LocationAnnotation.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 11/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
}
