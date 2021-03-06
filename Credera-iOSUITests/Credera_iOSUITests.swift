//
//  Credera_iOSUITests.swift
//  Credera-iOSUITests
//
//  Created by Zachary Slayter on 11/14/18.
//  Copyright © 2018 Credera. All rights reserved.
//

import XCTest

class Credera_iOSUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigation() {
        
        let app = XCUIApplication()
        XCTAssert(app.staticTexts["Navigation has not been completed"].exists)
        
        app.buttons["Navigation Example"].tap()
        
        let secondNavBtn = app.buttons["Navigate to final screen"]
        XCTAssert(secondNavBtn.waitForExistence(timeout: 5))
        secondNavBtn.tap()
        
        let thirdNavBtn = app.buttons["Navigate back to First VC"]
        XCTAssert(thirdNavBtn.waitForExistence(timeout: 5))
        thirdNavBtn.tap()
        
        XCTAssert(app.staticTexts["Navigation to Final VC has been completed"].exists)
        
    }
}
