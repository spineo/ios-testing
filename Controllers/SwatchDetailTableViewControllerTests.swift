//
//  SwatchTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class SwatchDetailTableViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "SwatchDetailTableViewController"
    var controller: SwatchDetailTableViewController = SwatchDetailTableViewController()
    
    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! SwatchDetailTableViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Controller exists
    //
    func testControllerExists() {
        XCTAssertNotNil(controller, "'\(controllerName)' is nil")
    }
    
    // Controller title
    //
    func testControllerTitle() {
        XCTAssertNotNil(controller.title!)
    }
    
    // TableView exists
    //
    func testTableView() {
        let tableView    = controller.tableView
        XCTAssertNotNil(tableView, "'\(controllerName)' tableview is nil")
    }
    
    // NavigationItem Back Button
    //
    func testBackButton() {
        let backButton   = controller.navigationItem.leftBarButtonItem!
        XCTAssertNotNil(backButton)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // NavigationItem Title
    //
    func testNavTitle() {
        XCTAssertNotNil(controller.navigationItem.title!)
    }
    
    // Toolbar Items (should be Nil)
    //
    func testToolbarItems() {
        XCTAssertNil(controller.toolbarItems)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["DetailToAssocSegue", "DetailToRefSegue"])
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let detailNC = storyboard.instantiateViewController(withIdentifier: "NavSwatchDetailTableViewController") as! UINavigationController
        XCTAssertTrue(detailNC.topViewController is SwatchDetailTableViewController, "'\(controllerName) is embedded in UINavigationController")
    }
    
    // Test direct actions
    //
    func testDirectActions() {
        // Top Navigation Bar action
        //
        XCTAssertTrue(controller.canPerformAction(Selector(("goBack:")), withSender:self))
        
        // View internal
        //
        verifyDirectActions(viewController:controller, actionList:["typesSelection", "colorSelection", "brandSelection", "bodySelection", "pigmentSelection", "coverageSelection"])
    }
    
    // Sections in TableView
    //
    func testTableViewSectionsCount() {
        XCTAssertEqual(Int32(controller.numberOfSections(in:controller.tableView)), DETAIL_MAX_SECTION-3)
    }
    
    // Test the Delegates
    //
    func testDelegates() {
        XCTAssertTrue(controller.tableView.delegate is UIPickerViewDataSource)
        XCTAssertTrue(controller.tableView.delegate is UIPickerViewDelegate)
        XCTAssertTrue(controller.tableView.delegate is UIActionSheetDelegate)
        XCTAssertTrue(controller.tableView.delegate is UITextFieldDelegate)
        XCTAssertTrue(controller.tableView.delegate is UITextViewDelegate)
        XCTAssertTrue(controller.tableView.delegate is UIGestureRecognizerDelegate)
        XCTAssertTrue(controller.tableView.delegate is UICollectionViewDataSource)
        XCTAssertTrue(controller.tableView.delegate is UICollectionViewDelegate)
    }
}
