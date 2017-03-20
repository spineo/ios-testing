//
//  AboutViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AboutViewControllerTests: RGButterflyBaseTests {

    let controllerName = "AboutViewController"
    var controller: AboutViewController = AboutViewController()

    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! AboutViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // Controller exists
    //
    func testControllerExists() {
        XCTAssertNotNil(controller, "'\(controllerName)' is nil")
    }
    
    // NavigationItem Back Button
    //
    func testBackButton() {
        let backButton = controller.navigationItem.leftBarButtonItem!
        XCTAssertNotNil(backButton)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // NavigationItem Title
    //
    func testNavTitle() {
       XCTAssertNotNil(controller.navigationItem.title!)
    }

    // Main View
    //
    func testMainView() {
       XCTAssertNotNil(controller.view)
    }
    
    // Main View Title
    //
    func testMainViewTitle() {
        XCTAssertNotNil(controller.title!)
    }
    
    // Confirm no segues
    //
    func testSegues() {
        let identifiers = getSeguesIdentifiers(viewController: controller)
        XCTAssertEqual(identifiers.count, 0, "Segue count")
    }
        
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavAboutViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is AboutViewController, "'\(controllerName)' is embedded in UINavigationController")
    }
        
    // Top Navigation Bar action
    //
    func testDirectActions() {
        XCTAssertTrue(controller.canPerformAction(Selector(("goBack:")), withSender:self))
    }
}
