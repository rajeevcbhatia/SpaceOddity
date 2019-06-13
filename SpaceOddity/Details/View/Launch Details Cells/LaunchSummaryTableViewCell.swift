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
    @IBOutlet weak var countdownLabel: UILabel! {
        didSet {
            countdownLabel.accessibilityIdentifier = Identifiers.countdownLabel.rawValue
        }
    }
    @IBOutlet weak var showDetailsButton: UIButton!
    
    @IBAction func showDetailsAction(_ sender: Any) {
        if let detailsURL = launch?.detailsURL {
            UIApplication.shared.open(detailsURL, options: [:], completionHandler: nil)
        }
    }
    
    weak var countdownTimer: Timer?
    
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
            if launch.detailsURL == nil { showDetailsButton.isEnabled = false; showDetailsButton.setTitle("Details unavailable", for: .normal) }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countdownTimer?.invalidate()
        countdownTimer = nil
        countdownLabel.text = ""
    }
    
    private func startTimer() {
        
        // do not use scheduledTimer with target and selector. causes memory leak here. if iOS9 is to be supported and this API is not available, dealloc timer in view willMoveToSuperview when superview is nil
        countdownTimer  = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            self?.updateTime()
        })
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
