//
//  MatchTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class MatchTableViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "MatchTableViewController"
    var controller: MatchTableViewController = MatchTableViewController()
    
    override func setUp() {
        super.setUp()

        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! MatchTableViewController
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
    
    // Toolbar Items
    //
    func testToolbarItems() {
        var toolbarItems   = controller.toolbarItems!
        
        let rgbButton       = toolbarItems.removeFirst()
        XCTAssertEqual(rgbButton.tag,      Int(RGB_BTN_TAG))
        XCTAssertTrue(rgbButton.isEnabled)
        
        let flexibleSpace   = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let decrAlgButton   = toolbarItems.removeFirst()
        XCTAssertEqual(decrAlgButton.tag,  Int(DECR_ALG_BTN_TAG))
        XCTAssertTrue(decrAlgButton.isEnabled)
        
        let matchButton     = toolbarItems.removeFirst()
        XCTAssertEqual(matchButton.tag,    Int(MATCH_BTN_TAG))
        XCTAssertTrue(matchButton.isEnabled)
        
        let incrAlgButton   = toolbarItems.removeFirst()
        XCTAssertEqual(incrAlgButton.tag,  Int(INCR_ALG_BTN_TAG))
        XCTAssertTrue(incrAlgButton.isEnabled)
        
        let flexibleSpace2  = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace2.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let decrTapButton   = toolbarItems.removeFirst()
        XCTAssertEqual(decrTapButton.tag,  Int(DECR_TAP_BTN_TAG))
        XCTAssertFalse(decrTapButton.isEnabled)
        
        let fixedSpace      = toolbarItems.removeFirst()
        XCTAssertEqual(fixedSpace.tag, Int(FIXED_SPACE_TAG))
        
        let incrTapButton   = toolbarItems.removeFirst()
        XCTAssertEqual(incrTapButton.tag,  Int(INCR_TAP_BTN_TAG))
        XCTAssertFalse(incrTapButton.isEnabled)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["unwindToImageViewFromMatch", "ShowSwatchDetailSegue", "unwindToImageViewFromMatch"])
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavMatchTableViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is MatchTableViewController, "'\(controllerName)' is embedded in UINavigationController")
    }
    
    // Test Unwind Actions
    //
    func testUnwindActions() {
        let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        XCTAssertTrue(imageVC.canPerformUnwindSegueAction(Selector(("unwindToImageViewFromMatch:")), from: controller, withSender:self))
    }
    
    // Test direct actions
    //
    func testDirectActions() {
        // Internal Views
        //
        verifyDirectActions(viewController:controller, actionList:["pressCell:"])
        
        // Toolbar
        //
        verifyDirectActions(viewController:controller, actionList:["toggleRGB:", "decr:", "toggleAction:", "incr:", "removeTableRows:", "addTableRows:"])
    }
}
