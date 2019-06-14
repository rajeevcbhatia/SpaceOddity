//
//  LaunchTableViewCell.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 08/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import SDWebImage

class LaunchTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: PaddingLabel!
    @IBOutlet weak var timeLabel: PaddingLabel!
    @IBOutlet weak var statusLabel: PaddingLabel! {
        didSet {
            statusLabel.clipsToBounds = true
            statusLabel.layer.cornerRadius = 5.0
        }
    }
    
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            
            nameLabel.text = launch.name
            statusLabel.backgroundColor = launch.statusColor
            statusLabel.text = launch.statusName
            
            if launch.shouldShowTimer {
                timeLabel.text = launch.dateString
            } else {
                timeLabel.text = "Time unknown"
            }
            
            bgImageView.sd_setImage(with: URL(string: launch.rocket.imageURL), completed: nil)
        }
    }
    
}
