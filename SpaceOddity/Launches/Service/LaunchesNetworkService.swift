//
//  LaunchesNetworkService.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

//generally this would be in a URLBuilder with separate parameters for version, path, number of launches etc but since this app is only dealing with one request, I am leaving it here
private let launchesPath = "https://launchlibrary.net/1.4/launch/next/100"

class LaunchesNetworkService: LaunchesServiceable {
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: launchesPath) { (result) in
            
            guard let resultData = try? result.get(), let launchesResponse: LaunchesResponse = Parser.decode(data: resultData) else {
                completion(.failure(ConnectionError.couldNotGetDetails))
                return
            }
            completion(.success(launchesResponse))
            
        }
        
    }
    
}
