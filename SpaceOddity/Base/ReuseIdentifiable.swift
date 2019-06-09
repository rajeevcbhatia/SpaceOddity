//
//  ReuseIdentifiable.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 08/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
