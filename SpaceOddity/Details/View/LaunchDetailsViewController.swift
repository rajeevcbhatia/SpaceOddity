//
//  LaunchDetailsViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MapKit

class LaunchDetailsViewController: BaseViewController {

    @IBOutlet weak var detailsTableView: UITableView! {
        didSet {
            detailsTableView.accessibilityIdentifier = Identifiers.launchDetailsTableView.rawValue
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
        defer { // to make sure didSet is called during init
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launch = launch else { return }
        let currentType = detailsRows[indexPath.row]
        currentType.didSelect(with: launch)
    }
    
}
