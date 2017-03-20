//
//  AddMixTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AddMixTableViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "AddMixTableViewController"
    var controller: AddMixTableViewController = AddMixTableViewController()
    
    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! AddMixTableViewController
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
    func testTableViewExists() {
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
    
    // NavigationItem Search Button
    //
    func testSearchButton() {
        let searchButton = controller.navigationItem.rightBarButtonItem!
        XCTAssertEqual(searchButton.tag, Int(SEARCH_BTN_TAG))
        XCTAssertTrue(searchButton.isEnabled)
    }
    
    // Toolbar Items
    //
    func testToolbarItems() {
        var toolbarItems  = controller.toolbarItems!
        
        let flexibleSpace = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let doneButton    = toolbarItems.removeFirst()
        XCTAssertEqual(doneButton.tag,    Int(DONE_BTN_TAG))
        XCTAssertFalse(doneButton.isEnabled)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["unwindToAssocFromAdd1", "unwindToAssocFromAdd2", "unwindToAssocFromAdd3"])
    }
    
        
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavAddMixTableViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is AddMixTableViewController, "'\(controllerName)' is embedded in UINavigationController")
    }
    
    // Test Unwind Actions
    //
    func testUnwindActions() {
        let assocTVC = storyboard.instantiateViewController(withIdentifier: "AssocTableViewController") as! AssocTableViewController
        XCTAssertTrue(assocTVC.canPerformUnwindSegueAction(Selector(("unwindToAssocFromAdd:")), from:controller, withSender:self))
    }
    
    // Test Direct Actions
    //
    func testDirectActions() {
        XCTAssertTrue(controller.canPerformAction(Selector(("searchMix:")), withSender:self))
    }
}
