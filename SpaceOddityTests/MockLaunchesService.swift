//
//  MockLaunchesService.swift
//  SpaceOddityTests
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
@testable import SpaceOddity

class MockLaunchesService: LaunchesServiceable {
    
    private let responseString: String
    init(responseString: String = MockLaunches.successResponseString) {
        self.responseString = responseString
    }
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void) {
        
        guard let responseData = responseString.data(using: .utf8) else {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        guard let launchesResponse: LaunchesResponse = Parser.decode(data: responseData) else {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        completion(.success(launchesResponse))
    }
}
