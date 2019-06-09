//
//  LaunchesResponse.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import UIKit

struct LaunchesResponse: Codable {
    let launches: [Launch]
}

struct Launch: Codable {
    let id: Int
    let name: String
    let netstamp: Int
    private let status: Int
    let vidURLs: [String]
    let location: Location
    let rocket: Rocket
    let missions: [Mission]
    let lsp: LaunchProvider
    
    var dateString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(netstamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a, EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    var missionName: String {
        return missions.first?.name ?? ""
    }
    
    //this is a hack. in the prod app, the statuses would be downloaded from the API
    var statusName: String {
        switch status {
        case 1:
            return "Go"
        case 3:
            return "Success"
        case 4:
            return "Failure"
        default:
            return "TBD"
        }
    }
    
    // also a hack, the colors could be in a constants file
    var statusColor: UIColor {
        switch status {
        case 1, 3:
            return .green
        case 4:
            return .red
        default:
            return .darkGray
        }
    }
}

struct Location: Codable {
    let pads: [Pad]
    let id: Int
    let name: String
    let countryCode: String
}

struct Pad: Codable {
    let id: Int
    let name: String
    let infoURL: String?
    let wikiURL: String?
    let mapURL: String?
    let latitude, longitude: Double
}

struct LaunchProvider: Codable {
    let id: Int
    let name, countryCode: String
    let wikiURL: String?
    let infoURLs: [String]
}

struct Mission: Codable {
    let id: Int
    let name, missionDescription: String
    let wikiURL: String
    let typeName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case missionDescription = "description"
        case wikiURL, typeName
    }
}

struct Rocket: Codable {
    let id: Int
    let name: String
    let wikiURL: String
    let infoURLs: [String]
    let imageSizes: [Int]
    let imageURL: String
}
