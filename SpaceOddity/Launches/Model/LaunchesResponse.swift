//
//  LaunchesResponse.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct LaunchesResponse: Codable {
    let launches: [Launch]
}

struct Launch: Codable {
    let id: Int
    let name: String
    let netstamp: Int
    private let status: Int
    let vidURLs: [String]
    let infoURLs: [String]
    let location: Location
    let rocket: Rocket
    let missions: [Mission]
    let lsp: LaunchProvider
    
    var detailsURL: URL? {
        if let vidURL = vidURLs.first, vidURL.count > 0 {
            return URL(string: vidURL)
        }
        if let infoURL = infoURLs.first, infoURL.count > 0 {
            return URL(string: infoURL)
        }
        return rocket.infoURL
    }
    
    var dateString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(netstamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a, EEEE\nMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    // this is called searcheableParameter so that the model makes the business decision about what is to be searched, not the VC
    var searcheableParameter: String {
        return missions.first?.name ?? ""
    }
    
    //this is a hack. in a prod app, the statuses would be downloaded from the API. also the status names would be enums and not used as raw strings
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
    
    var shouldShowTimer: Bool {
        return statusName == "Go" || statusName == "Success"
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
    private let pads: [Pad]
    let id: Int
    let name: String
    let countryCode: String
    var coordinate: CLLocationCoordinate2D? {
        guard let pad = pads.first else { return nil }
        return CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)
    }
}

private struct Pad: Codable {
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
    
    var infoURL: URL? {
        if wikiURL.count > 0 {
            return URL(string: wikiURL)
        } else if let firstInfoURL = infoURLs.first, firstInfoURL.count > 0 {
            return URL(string: firstInfoURL)
        }
        return nil
    }
}
