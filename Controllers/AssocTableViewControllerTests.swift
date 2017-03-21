//
//  AssocTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AssocTableViewControllerTests: RGButterflyBaseTests {

    let controllerName = "AssocTableViewController"
    var controller: AssocTableViewController = AssocTableViewController()
    
    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! AssocTableViewController
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
        
        let homeButton     = toolbarItems.removeFirst()
        XCTAssertEqual(homeButton.tag,     Int(HOME_BTN_TAG))
        XCTAssertTrue(homeButton.isEnabled)
        
        let flexibleSpace  = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let settingsButton = toolbarItems.removeFirst()
        XCTAssertEqual(settingsButton.tag, Int(SETTINGS_BTN_TAG))
        XCTAssertTrue(settingsButton.isEnabled)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["AddMixSegue", "AssocSwatchDetailSegue",
                                                              "unwindToImageViewFromAssoc", "unwindToVC", "SettingsSegue"])
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavAssocTableViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is AssocTableViewController, "'\(controllerName)' is embedded in UINavigationController")
    }
    
    // Test Unwind Actions
    //
    func testUnwindActions() {
        let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        XCTAssertTrue(imageVC.canPerformUnwindSegueAction(Selector(("unwindToImageViewFromAssoc:")), from: controller, withSender:self))

        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from: controller, withSender:self))
    }
    
    // Test direct actions
    //
    func testDirectActions() {
        verifyDirectActions(viewController:controller, actionList:["showAssocTypePicker", "showCoveragePicker", "showMixRatiosPicker", "applyRenaming", "ratiosSelection", "assocTypeSelection", "coverageSelection"])
    }
    
    // Test the Delegates
    //
    func testDelegates() {
        XCTAssertTrue(controller.tableView.delegate is UITextFieldDelegate)
        XCTAssertTrue(controller.tableView.delegate is NSFetchedResultsControllerDelegate)
        XCTAssertTrue(controller.tableView.delegate is UIPickerViewDelegate)
        XCTAssertTrue(controller.tableView.delegate is UIPickerViewDataSource)
        XCTAssertTrue(controller.tableView.delegate is UIGestureRecognizerDelegate)
    }
}
