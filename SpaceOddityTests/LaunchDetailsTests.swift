//
//  LaunchDetailsTests.swift
//  SpaceOddityTests
//
//  Created by Rajeev Bhatia on 12/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
import UIKit
@testable import SpaceOddity

class LaunchDetailsTests: XCTestCase {

    private var launchDetailsVC: LaunchDetailsViewController?
    
    private lazy var allLaunches: [Launch]? = {
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

    func testAllComponentsLoaded() {
        assertComponentsLoaded(launchIndex: MockLaunches.indexOfCompleteLaunch, expectedDetailsRows: [DetailsRowType.summary, .rocket, .mission, .location])
    }
    
    func testLaunchWithoutMission() {
        assertComponentsLoaded(launchIndex: MockLaunches.indexOfLaunchWithoutMission, expectedDetailsRows: [DetailsRowType.summary, .rocket, .location])
    }
    
    func testLaunchWithoutLocation() {
        assertComponentsLoaded(launchIndex: MockLaunches.indexOfLaunchWithoutPad, expectedDetailsRows: [DetailsRowType.summary, .rocket, .mission])
    }
    
    func testWillNotShowTimerForLaunchWithTBD() {
        guard let launch = allLaunches?[MockLaunches.indexOfLaunchWithoutDate] else {
            XCTFail("could not load all launch for test")
            return
        }
        XCTAssertEqual(launch.statusColor, UIColor.darkGray, "correct color not set for launch that has TBD status")
        XCTAssertFalse(launch.shouldShowTimer, "will show timer for launch that has TBD status")
    }
    
    private func assertComponentsLoaded(launchIndex: Int, expectedDetailsRows: [DetailsRowType]) {
        
        guard let launch = allLaunches?[launchIndex] else {
            XCTFail("could not load all launch for test")
            return
        }
        
        initSUT(with: launch)
        
        guard let launchDetailsVC = launchDetailsVC else {
            XCTFail("could not load all launch for test")
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
}
