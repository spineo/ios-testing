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
    // (1) Photo Library and Take Photo (top left icon)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // Select an image from the Photo Library
    //
    func testPhotoLibrarySelection() {
        let app = XCUIApplication()
        app.navigationBars["RGButterfly"].buttons["photo 2"].tap()
        app.alerts["Photo Selection"].buttons["My Photo Library"].tap()
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
    
    // Take Photo (should give alerts error in the simulator)
    //
    func testTakePhoto() {
        let app = XCUIApplication()
        app.navigationBars["RGButterfly"].buttons["photo 2"].tap()
        
        let takeNewPhotoButton = app.alerts["Photo Selection"].buttons["Take New Photo"]
        takeNewPhotoButton.tap()
    }

    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (2) Search (top right)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Simple tap
    //
    func testSearchTap() {
        
        let app = XCUIApplication()
        let rgbutterflyNavigationBar = app.navigationBars["RGButterfly"]
        let searchButton = rgbutterflyNavigationBar.buttons["search"]
        searchButton.tap()
    }
    
    // Test on iPhone
    //
    func testSearchAssociation() {
        
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (3) Switch Listings
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Need to expand to Full Listing and Cancel
    //
    func testSwitchListings() {
        let app = XCUIApplication()
        let button = app.toolbars.children(matching: .button).element(boundBy: 1)
        button.tap()
        
        let colorsListingsAlert = app.alerts["Colors Listings"]
        colorsListingsAlert.buttons["Match Associations"].tap()
        button.tap()
        colorsListingsAlert.buttons["Subjective Colors"].tap()
        button.tap()
        colorsListingsAlert.buttons["Keywords Listing"].tap()
        button.tap()
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (4) Settings
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // About and Feedback: Go into the sections and scroll
    //
    func testSettingsAboutAndFeedBack() {
        let app = XCUIApplication()
        app.toolbars.children(matching: .button).element(boundBy: 2).tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["About this App"].tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.tap()
        app.navigationBars["About this App"].buttons["arrow"].tap()
        tablesQuery.staticTexts["Disclaimer"].tap()
        textView.swipeUp()
        app.navigationBars["Disclaimer"].buttons["arrow"].tap()
        tablesQuery.staticTexts["Provide Feedback"].tap()
        
        // Send email
        //
        app.navigationBars["Feedback"].buttons["Send"].tap()
    }
    
    // Test the Database Switches, Save, and Exit
    //
    func testSettingsDatabaseSwitches() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.switches["Perform Check for Database Update"].tap()
        tablesQuery.switches["Do Not Check for Database Update"].tap()
        tablesQuery.switches["Do Not Perform a Force Database Update"].tap()
        tablesQuery.switches["Update Even if Versions are Unchanged"].tap()
        
        let rgbutterflySettingsNavigationBar = app.navigationBars["RGButterfly Settings"]
        rgbutterflySettingsNavigationBar.buttons["Save"].tap()
        rgbutterflySettingsNavigationBar.buttons["arrow"].tap()
    }
    
    // Test the scroll and Read-Only/Alert Switches
    //
    func testSettingsIntoViewAndScroll() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["settings"].tap()
        app.tables.staticTexts["Read-Only Settings"].swipeUp()
        app.navigationBars["RGButterfly Settings"].buttons["arrow"].tap()
        
    }
    
    func testSettingsReadOnlySwitches() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["settings"].tap()
        
        let tablesQuery2 = app.tables
        let paintSwatchesSetToReadWriteSwitch = tablesQuery2.switches["Paint Swatches set to Read/Write"]
        paintSwatchesSetToReadWriteSwitch.tap()

        
        let tablesQuery = tablesQuery2
        tablesQuery.switches["Paint Swatches set to Read-Only"].tap()
        tablesQuery.staticTexts["Paint Swatches set to Read/Write"].tap()
        tablesQuery.switches["Mix Associations set to Read/Write"].press(forDuration: 0.6);
        tablesQuery.switches["Mix Associations set to Read-Only"].tap()
    }
    
    // Revisit: Passes with below configuration but got pop-up 'Xcode UI Testing - Timestamped Event Matching Error' 
    // when starting test by incrementing the 'TAP AREA SETTINGS' stepper
    //
    func testSettingsSteppersAndButtons() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Change the Size/Shape of the Tap Areas").buttons["Decrement"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"Change the Size/Shape of the Tap Areas").buttons["Decrement"].tap()
        
        let changeTheDefaultNumberOfTapAreaMatchesCellsQuery = tablesQuery.cells.containing(.staticText, identifier:"Change the Default Number of Tap Area matches")
        changeTheDefaultNumberOfTapAreaMatchesCellsQuery.buttons["Increment"].tap()
        changeTheDefaultNumberOfTapAreaMatchesCellsQuery.buttons["Decrement"].tap()
        
        let tablesQuery2 = tablesQuery
        tablesQuery2.buttons["Circle"].tap()
        tablesQuery2.buttons["Rect"].tap()
    }
    
    // Failing: 'Xcode UI Testing - Timestamped Event Matching Error'
    //
    func testRGBAndPaintToggle() {
        
    }
    
    // To be implemented
    //
    func testSettingsMixRatiosInput() {
    }
    
    // To be re-implemented (Fails)
    //
    func testAlertsSwitch() {
        XCUIDevice.shared().orientation = .portrait
        XCUIApplication().toolbars.buttons["settings"].tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery.switches["Turn On All Alerts"].tap()
        tablesQuery.switches["Turn Off All Alerts"].tap()
        
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (5) Full Listing Categories: All, Ref, Gen (Main VC)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Needs Completion: Unable to capture, probably needs pre-filter to limit number
    //
    func testFullListingCategories() {
        let app = XCUIApplication()
        app.toolbars.children(matching: .button).element(boundBy: 1).tap()
        app.alerts["Colors Listings"].buttons["Full Colors Listings"].tap()
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (6) Main VC to Children VCs
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    // From 'Color Associations' listing segue to Mix Association
    //
    func testColorsListToMixAssoc() {
        XCUIDevice.shared().orientation = .portrait
        XCUIApplication().tables.staticTexts["Alizarin Crimson Hue + Burnt Siena"].tap()
    }
    
    // Switch to Match Listing and segue to Match Association
    // Failing: 'Xcode UI Testing - Timestamped Event Matching Error' on segue to Match Association
    //
    func testMatchListToMatchAssoc() {
        XCUIDevice.shared().orientation = .portrait
        let app = XCUIApplication()
        app.toolbars.buttons["text list 1"].tap()
        app.alerts["Colors Listings"].buttons["Match Associations"].tap()
    }
    
    // Switch to Full Colors Listing and segue to Detail
    //
    func testFullListToDetail() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["text list 1"].tap()
        app.alerts["Colors Listings"].buttons["Full Colors Listings"].tap()
    }
    
    // Switch to Keywords Listing and segue to Swatch Detail
    //
    func testKeywordsToDetail() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.toolbars.buttons["text list 1"].tap()
        app.alerts["Colors Listings"].buttons["Keywords Listing"].tap()
        
        let cell = app.tables.children(matching: .cell).element(boundBy: 1)
        cell.staticTexts["Burnt Umber + Cadmium Yellow Medium 1:3"].tap()
        cell.children(matching: .textField).element.tap()
    }
    
    // Switch to Subjective Colors, uncollapse one element, and segue to Detail
    //
    func testSubjColorsUncollapseToDetail() {

        
    }
    
    // Switch to Subjective Colors and Uncollapse all
    //
    func testSubjColorsUncollapseAll() {
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (7) Main View Controller to Match Association (currently fails)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    func testViewControllerToMatchAssoc() {
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // (7) Main View Controller to Color Association and Swatch Detail (currently fails)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    func testViewControllerToColorAssocToDetail() {
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .portrait
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()


        
    }
}
