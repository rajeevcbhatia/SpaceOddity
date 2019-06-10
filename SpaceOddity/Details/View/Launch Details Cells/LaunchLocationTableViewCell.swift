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
            guard let location = location, let coordinte = location.coordinate else { return }
            nameLabel.text = location.name
            mapView.setCenter(coordinte, animated: false)
        }
    }
    
}
