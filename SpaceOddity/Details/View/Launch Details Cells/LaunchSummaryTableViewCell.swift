//
//  LaunchSummaryTableViewCell.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchSummaryTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var countdownTimer: Timer?
    
    var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            nameLabel.text = launch.name
            if launch.statusName == "TBD" {
                countdownLabel.text = "Time unknown"
            } else {
                startTimer()
                updateTime()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countdownTimer?.invalidate()
        countdownTimer = nil
        countdownLabel.text = ""
    }
    
    private func startTimer() {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        guard let launch = launch else { return }
        let launchDate = Date(timeIntervalSince1970: TimeInterval(launch.netstamp))
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: launchDate)
        
        let countdown = "\(diffDateComponents.day ?? 0) d:  \(diffDateComponents.hour ?? 0) h: \(diffDateComponents.minute ?? 0) m: \(diffDateComponents.second ?? 0) s"
        
        countdownLabel.text = countdown
    }
}
