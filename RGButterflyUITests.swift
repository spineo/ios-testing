//
//  RGButterflyUITests.swift
//  RGButterflyUITests
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest


class RGButterflyUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        //
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        // Launch new instance of the App
        //
        XCUIApplication().launch()

        // this is the line responsible for the race condition
        //NSRunLoop.mainRunLoop().runUntilDate(NSDate())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //
        super.tearDown()
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Main ViewController UI Testing
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (1) Photo Library
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Select an image from the Photo Library
    //
    func testPhotoLibrarySelection() {
        let app = XCUIApplication()
        app.navigationBars["RGButterfly"].buttons["photo 2"].tap()
        app.alerts["Photo Selection"].buttons["My Photo Library"].tap()
        app.tables.buttons["Moments"].tap()
        app.collectionViews["PhotosGridView"].cells["Photo, Landscape, March 12, 2011, 7:17 PM"].tap()
    }
    
    // Cancel button at the 'Photo Selection' popup
    //
    func testPhotoSelectionCancel() {
        let app = XCUIApplication()
        app.navigationBars["RGButterfly"].buttons["photo 2"].tap()
        app.alerts["Photo Selection"].buttons["Cancel"].tap()
    }

    // First Cancel button after the Photo Library load
    //
    func testPhotoLibrarySelectionCancel() {
        let app = XCUIApplication()
        app.navigationBars["RGButterfly"].buttons["photo 2"].tap()
        app.alerts["Photo Selection"].buttons["My Photo Library"].tap()
        app.navigationBars["Photos"].buttons["Cancel"].tap()
    }
}
