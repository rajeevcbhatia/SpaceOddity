//
//  SpaceOddityUITests.swift
//  SpaceOddityUITests
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest

class SpaceOddityUITests: XCTestCase {

    private let happyFlowParameter = "testHappyFlow"
    private let errorFlowParameter = "testErrorFlow"
    
    private var launchesTableView: XCUIElement {
        return app.tables[Identifiers.launchesTableView.rawValue]
    }
    
    private var launchDetailsTableView: XCUIElement {
        return app.tables[Identifiers.launchDetailsTableView.rawValue]
    }
    
    private var countdownLabel: XCUIElement {
        return app.staticTexts[Identifiers.countdownLabel.rawValue]
    }
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    private func launchApp(with arguments: [String]) {
        app.launchArguments = arguments
        app.launch()
    }
    
    func testErrorShown() {
        
        launchApp(with: [errorFlowParameter])
        
        let alert = app.alerts.firstMatch
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testAllRowsShownAndSearchWorking() {
        
        launchApp(with: [happyFlowParameter])
        
        XCTAssert(launchesTableView.cells.count == MockLaunches.launchesCount, "all launches not loaded at start")
        
        app.searchFields.firstMatch.tap()
        app.searchFields.firstMatch.typeText(MockLaunches.searchQuery)
        
        XCTAssert(launchesTableView.cells.count == MockLaunches.expectedNumberOfSearches, "launches search not working")
    }
    
    func testAllLaunchDetailsLoaded() {
        launchApp(with: [happyFlowParameter])
        
        launchesTableView.cells.element(boundBy: MockLaunches.indexOfCompleteLaunch).tap()
        
        XCTAssert(launchDetailsTableView.cells.count == MockLaunches.numberOfRowsForCompleteLaunch, "all launch details not loaded")
    }
    
    func testCountdownTextChangingForLaunchWithTime() {
        launchApp(with: [happyFlowParameter])
        launchesTableView.cells.element(boundBy: MockLaunches.indexOfCompleteLaunch).tap()
        
        let oldCountdownText = countdownLabel.label
        sleep(3)
        let newCountdownText = countdownLabel.label
        
        XCTAssertNotEqual(oldCountdownText, newCountdownText, "coundown text not changing")
    }
    
    func testCountdownTextChangingForLaunchWithTBD() {
        launchApp(with: [happyFlowParameter])
        launchesTableView.cells.element(boundBy: MockLaunches.indexOfLaunchWithoutDate).tap()
        
        let oldCountdownText = countdownLabel.label
        sleep(3)
        let newCountdownText = countdownLabel.label
        
        XCTAssertEqual(oldCountdownText, newCountdownText, "coundown text changing for launch with TBD")
    }

}
