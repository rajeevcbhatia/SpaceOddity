//
//  LaunchDetailsViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchDetailsViewController: BaseViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    private var detailsRows = [DetailsRowType]()
    
    private var launch: Launch {
        didSet {
            detailsRows = [.summary, .rocket, .location]
            if let _ = launch.missions.first {
               detailsRows.insert(.mission, at: 2)
            }
        }
    }
    
    init(launch: Launch) {
        self.launch = launch
        super.init(nibName: String(describing: LaunchDetailsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LaunchDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentType = detailsRows[indexPath.row]
        
        return currentType.configuredCell(with: launch, tableView: detailsTableView, indexPath: indexPath)
    }
    
}

private enum DetailsRowType {
    case summary
    case rocket
    case mission
    case location
    
    func configuredCell(with launch: Launch, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .summary:
            guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: LaunchSummaryTableViewCell.reuseIdentifier, for: indexPath) as? LaunchSummaryTableViewCell else { return UITableViewCell() }
            summaryCell.launch = launch //make LaunchDetailsDisplayable and override all cells
            return summaryCell
        case .rocket:
            return UITableViewCell()
        case .mission:
            return UITableViewCell()
        case .location:
            return UITableViewCell()
        }
    }
}
