//
//  LaunchesViewControllerTests.swift
//  SpaceOddityTests
//
//  Created by Rajeev Bhatia on 09/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import SpaceOddity

class LaunchesViewControllerTests: XCTestCase {

    private var launchesViewController: LaunchesViewController?
    
    override func tearDown() {
        super.tearDown()
        launchesViewController = nil
    }
    
    private func createSut(with service: LaunchesServiceable) {
        launchesViewController = LaunchesViewController(service: service)
        _ = launchesViewController?.view
    }
    
    func testLaunchesModel() {
        let launchesService = MockLaunchesService()
        
        launchesService.fetchLaunches { (response) in
            guard let launchesResponse = try? response.get() else {
                XCTFail("Could not parse mock response. please check model")
                return
            }
            guard launchesResponse.launches.count == MockLaunches.launchesCount else {
                XCTFail("all launches not parsed")
                return
            }
        }
    }
    
    func testLaunchesListAndSearch() {
        let launchesService = MockLaunchesService()
        createSut(with: launchesService)
        
        guard let launchesVC = launchesViewController else { XCTFail("could not load launches list"); return }
        
        let expectation = XCTestExpectation(description: "launches list expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            let numberOfRows = launchesVC.launchesTableView.numberOfRows(inSection: 0)
            XCTAssertEqual(numberOfRows, MockLaunches.launchesCount, "all launches not loaded")
            
            launchesVC.didSearch(query: MockLaunches.searchQuery)
            let searchResultsCount = launchesVC.filteredLaunches.count
            
            XCTAssertEqual(searchResultsCount, MockLaunches.expectedNumberOfSearches, "search did not work")
            
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 10.0)
    }
}
