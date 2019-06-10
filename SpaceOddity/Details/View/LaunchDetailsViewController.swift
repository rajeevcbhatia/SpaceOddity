//
//  LaunchDetailsViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchDetailsViewController: BaseViewController {

    @IBOutlet weak var detailsTableView: UITableView! {
        didSet {
            detailsTableView.dataSource = self
            detailsTableView.delegate = self
            registerCells()
        }
    }
    private var detailsRows = [DetailsRowType]()
    
    private var launch: Launch? {
        didSet {
            guard let launch = launch else { return }
            detailsRows = DetailsRowType.detailsRows(for: launch)
        }
    }
    
    init(launch: Launch) {
        super.init(nibName: String(describing: LaunchDetailsViewController.self), bundle: nil)
        defer {
            self.launch = launch
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        detailsTableView.register(UINib(nibName: LaunchSummaryTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchSummaryTableViewCell.reuseIdentifier)
        detailsTableView.register(UINib(nibName: LaunchRocketTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchRocketTableViewCell.reuseIdentifier)
        detailsTableView.register(UINib(nibName: LaunchMissionTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchMissionTableViewCell.reuseIdentifier)
        detailsTableView.register(UINib(nibName: LaunchLocationTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchLocationTableViewCell.reuseIdentifier)
    }
    
}

extension LaunchDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let launch = launch else { return UITableViewCell() }
        let currentType = detailsRows[indexPath.row]
        
        return currentType.configuredCell(with: launch, tableView: detailsTableView, indexPath: indexPath)
        
    }
    
}

private enum DetailsRowType {
    case summary
    case rocket
    case mission
    case location
    
    static func detailsRows(for launch: Launch) -> [DetailsRowType] {
        var detailsRows = [DetailsRowType.summary, .rocket]
        if let _ = launch.missions.first {
            detailsRows.append(.mission)
        }
        if let _ = launch.location.coordinate {
            detailsRows.append(.location)
        }
        return detailsRows
    }
    
    func configuredCell(with launch: Launch, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .summary:
            guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: LaunchSummaryTableViewCell.reuseIdentifier, for: indexPath) as? LaunchSummaryTableViewCell else { return UITableViewCell() }
            summaryCell.launch = launch
            return summaryCell
        case .rocket:
            guard let rocketCell = tableView.dequeueReusableCell(withIdentifier: LaunchRocketTableViewCell.reuseIdentifier, for: indexPath) as? LaunchRocketTableViewCell else { return UITableViewCell() }
            rocketCell.rocket = launch.rocket
            return rocketCell
        case .mission:
            guard let missionCell = tableView.dequeueReusableCell(withIdentifier: LaunchMissionTableViewCell.reuseIdentifier, for: indexPath) as? LaunchMissionTableViewCell else { return UITableViewCell() }
            missionCell.mission = launch.missions.first
            return missionCell
        case .location:
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: LaunchLocationTableViewCell.reuseIdentifier, for: indexPath) as? LaunchLocationTableViewCell else { return UITableViewCell() }
            locationCell.location = launch.location
            return locationCell
        }
    }
}
