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
    
    private let strokeTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -2.0,
        .font : UIFont.boldSystemFont(ofSize: 18.0)
    ]

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var agencyDetailsLabel: UILabel!
    
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            
            nameLabel.attributedText = NSAttributedString(string: launch.name, attributes: strokeTextAttributes)
            timeLabel.attributedText = NSAttributedString(string: launch.dateString, attributes: strokeTextAttributes)
            statusLabel.backgroundColor = launch.statusColor
            statusLabel.attributedText = NSAttributedString(string: launch.statusName, attributes: strokeTextAttributes)
            
            locationNameLabel.attributedText = NSAttributedString(string: launch.location.name, attributes: strokeTextAttributes)
            let agencyDetails = "\(launch.lsp.name), \(launch.lsp.countryCode)"
            agencyDetailsLabel.attributedText = NSAttributedString(string: agencyDetails, attributes: strokeTextAttributes)
            
            bgImageView.sd_setImage(with: URL(string: launch.rocket.imageURL), completed: nil)
        }
    }
    
}
