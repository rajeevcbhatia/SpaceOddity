//
//  LaunchDetailsTests.swift
//  SpaceOddityTests
//
//  Created by Rajeev Bhatia on 12/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import SpaceOddity

class LaunchDetailsTests: XCTestCase {

    var launchDetailsVC: LaunchDetailsViewController?
    
    lazy var allLaunches: [Launch]? = {
        guard let launchData = MockLaunches.successResponseString.data(using: .utf8), let launchesResponse: LaunchesResponse = Parser.decode(data: launchData) else { return nil }
        return launchesResponse.launches
    }()
    
    private func initSUT(with launch: Launch) {
        launchDetailsVC = LaunchDetailsViewController(launch: launch)
        _ = launchDetailsVC?.view
    }
    
    override func tearDown() {
        super.tearDown()
        launchDetailsVC = nil
    }
    
    func testComponentsLoaded(launchIndex: Int, expectedDetailsRows: [DetailsRowType]) {
        
        guard let launch = allLaunches?[launchIndex] else {
            XCTFail("could not load all launch for testAllComponentsLoaded")
            return
        }
        
        initSUT(with: launch)
        
        guard let launchDetailsVC = launchDetailsVC else {
            XCTFail("could not load all launch for testAllComponentsLoaded")
            return
        }
        let detailsRows = DetailsRowType.detailsRows(for: launch)
        XCTAssertEqual(detailsRows, expectedDetailsRows, "details rows not correctly loaded")
        let expectation = XCTestExpectation(description: "launch details expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let numberOfRows = launchDetailsVC.detailsTableView.numberOfRows(inSection: 0)
            XCTAssertEqual(numberOfRows, detailsRows.count, "all details not loaded")
        }
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)
    }

    func testAllComponentsLoaded() {
        testComponentsLoaded(launchIndex: MockLaunches.indexOfCompleteLaunch, expectedDetailsRows: [DetailsRowType.summary, .rocket, .mission, .location])
    }
    
    func testLaunchWithoutMission() {
        testComponentsLoaded(launchIndex: MockLaunches.indexOfLaunchWithoutMission, expectedDetailsRows: [DetailsRowType.summary, .rocket, .location])
    }
    
    func testLaunchWithoutLocation() {
        testComponentsLoaded(launchIndex: MockLaunches.indexOfLaunchWithoutPad, expectedDetailsRows: [DetailsRowType.summary, .rocket, .mission])
    }
}
