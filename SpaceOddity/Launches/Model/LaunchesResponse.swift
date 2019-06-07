//
//  LaunchesResponse.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

struct LaunchesResponse: Codable {
    let launches: [Launch]
    let total, offset, count: Int
}

struct Launch: Codable {
    let id: Int
    let name, windowstart, windowend, net: String
    let wsstamp, westamp, netstamp: Int
    let isostart, isoend, isonet: String
    let status, inhold, tbdtime: Int
    let vidURLs: [String]
    let vidURL: String?
    let infoURLs: [String]
    let infoURL: String?
    let holdreason, failreason: String?
    let tbddate, probability: Int
    let hashtag: String?
    let changed: String
    let location: Location
    let rocket: Rocket
    let missions: [Mission]
    let lsp: Lsp
}

struct Location: Codable {
    let pads: [Pad]
    let id: Int
    let name: String
    let infoURL: String
    let wikiURL: String
    let countryCode: String
}

struct Pad: Codable {
    let id: Int
    let name: String
    let infoURL: String?
    let wikiURL: String?
    let mapURL: String?
    let latitude, longitude: Double
    let agencies: [Lsp]?
}

struct Lsp: Codable {
    let id: Int
    let name, abbrev, countryCode: String
    let type: Int
    let infoURL: String?
    let wikiURL: String?
    let changed: String
    let infoURLs: [String]
}

struct Mission: Codable {
    let id: Int
    let name, missionDescription: String
    let type: Int
    let wikiURL: String
    let typeName: String
    let agencies: [Lsp]?
    let payloads: [Payload]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case missionDescription = "description"
        case type, wikiURL, typeName, agencies, payloads
    }
}

struct Payload: Codable {
    let id: Int
    let name: String
}

struct Rocket: Codable {
    let id: Int
    let name, configuration, familyname: String
    let agencies: [Lsp]?
    let wikiURL: String
    let infoURLs: [String]
    let infoURL: String?
    let imageSizes: [Int]
    let imageURL: String
}
