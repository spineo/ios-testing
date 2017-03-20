//
//  SwatchTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class SwatchTableViewControllerTests: RGButterflyBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // SwatchDetailTableViewController
    //
    func testSwatchDetailTableViewController() {
        var detailTVC: SwatchDetailTableViewController = SwatchDetailTableViewController()
        detailTVC = storyboard.instantiateViewController(withIdentifier: "SwatchDetailTableViewController") as! SwatchDetailTableViewController
        
        tableView  = detailTVC.tableView
        backButton = detailTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(detailTVC.navigationItem.title!)
        XCTAssertNotNil(detailTVC.title!)
        XCTAssertNil(detailTVC.toolbarItems)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:detailTVC, seguesList:["DetailToAssocSegue", "DetailToRefSegue"])
        
        // Test the NavigationController
        //
        var detailNC: UINavigationController = UINavigationController()
        detailNC = storyboard.instantiateViewController(withIdentifier: "NavSwatchDetailTableViewController") as! UINavigationController
        XCTAssertTrue(detailNC.topViewController is SwatchDetailTableViewController, "SwatchDetailTableViewController is embedded in UINavigationController")
        
        // Top Navigation Bar action
        //
        XCTAssertTrue(detailTVC.canPerformAction(Selector(("goBack:")), withSender:self))
        
        // View internal
        //
        verifyDirectActions(viewController:detailTVC, actionList:["typesSelection", "colorSelection", "brandSelection", "bodySelection", "pigmentSelection", "coverageSelection"])
        
        // Verify tableView components
        //
        // No data load first
        //
        XCTAssertEqual(Int32(detailTVC.numberOfSections(in:tableView)), DETAIL_MAX_SECTION-3)
    }
}
