//
//  DetailsRowType.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 12/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum DetailsRowType {
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
    
    func didSelect(with launch: Launch) {
        switch self {
        case .location:
            guard let coordinate = launch.location.coordinate else { return }
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
            destination.name = launch.name
            
            MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        case .rocket:
            guard let infoURL = launch.rocket.infoURL else { return }
            UIApplication.shared.open(infoURL, options: [:], completionHandler: nil)
        default:
            return
        }
    }
}
