//
//  LaunchRocketTableViewCell.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchRocketTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var rocketImageView: UIImageView!
    
    @IBOutlet weak var rocketNameLabel: PaddingLabel!
    
    var rocket: Rocket? {
        didSet {
            guard let rocket = rocket else {
                return
            }
            rocketNameLabel.text = rocket.name
            rocketImageView.sd_setImage(with: URL(string: rocket.imageURL), completed: nil)
        }
    }
}
