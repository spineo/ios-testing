//
//  DisclaimerViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class DisclaimerViewControllerTests: RGButterflyTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // DisclaimerViewController
    //
    func testDisclaimerViewController() {
        var disclaimerVC: DisclaimerViewController = DisclaimerViewController()
        disclaimerVC = storyboard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        
        backButton = disclaimerVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(disclaimerVC.view)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(disclaimerVC.navigationItem.title!)
        XCTAssertNotNil(disclaimerVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        let identifiers = getSeguesIdentifiers(viewController:disclaimerVC)
        XCTAssertEqual(identifiers.count, 0, "Segue count")
        
        // Test the NavigationController
        //
        var disclaimerNC: UINavigationController = UINavigationController()
        disclaimerNC = storyboard.instantiateViewController(withIdentifier: "NavDisclaimerViewController") as! UINavigationController
        XCTAssertTrue(disclaimerNC.topViewController is DisclaimerViewController, "DisclaimerViewController is embedded in UINavigationController")
        
        // Top Navigation Bar action
        //
        XCTAssertTrue(disclaimerVC.canPerformAction(Selector(("goBack:")), withSender:self))
    }
}
