//
//  LaunchMissionTableViewCell.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchMissionTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var mission: Mission? {
        didSet {
            guard let mission = mission else { return }
            nameLabel.text = mission.name
            descriptionLabel.text = mission.missionDescription
        }
    }
}
