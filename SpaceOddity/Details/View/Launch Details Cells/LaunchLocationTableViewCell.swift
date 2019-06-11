//
//  LaunchLocationTableViewCell.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MapKit

class LaunchLocationTableViewCell: UITableViewCell, ReuseIdentifiable {

    @IBOutlet weak var nameLabel: PaddingLabel!
    @IBOutlet weak var mapView: MKMapView!
    var location: Location? {
        didSet {
            guard let location = location, let coordinate = location.coordinate else { return }
            nameLabel.text = location.name
            let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(integerLiteral: 10000), longitudinalMeters: CLLocationDistance(integerLiteral: 10000))
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.isUserInteractionEnabled = false
            mapView.addAnnotation(LocationAnnotation.init(title: location.name, coordinate: coordinate))
        }
    }
}
