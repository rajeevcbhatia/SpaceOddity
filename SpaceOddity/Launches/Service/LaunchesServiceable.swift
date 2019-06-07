//
//  LaunchesServiceable.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol LaunchesServiceable {
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void)
    
}
