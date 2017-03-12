//
//  AboutViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AboutViewControllerTests: RGButterflyTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // AboutViewController
    //
    func testAboutViewController() {
        var aboutVC: AboutViewController = AboutViewController()
        aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        
        backButton = aboutVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(aboutVC.view)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(aboutVC.navigationItem.title!)
        XCTAssertNotNil(aboutVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        let identifiers = getSeguesIdentifiers(viewController:aboutVC)
        XCTAssertEqual(identifiers.count, 0, "Segue count")
        
        // Test the NavigationController
        //
        var aboutNC: UINavigationController = UINavigationController()
        aboutNC = storyboard.instantiateViewController(withIdentifier: "NavAboutViewController") as! UINavigationController
        XCTAssertTrue(aboutNC.topViewController is AboutViewController, "AboutViewController is embedded in UINavigationController")
    }
}
