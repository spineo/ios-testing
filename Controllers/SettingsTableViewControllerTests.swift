//
//  SettingsViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class SettingsTableViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "SettingsTableViewController"
    var controller: SettingsTableViewController = SettingsTableViewController()

    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! SettingsTableViewController
        
        controller.viewDidLoad()
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
    
    // TableView exists
    //
    func testTableView() {
        let tableView    = controller.tableView
        XCTAssertNotNil(tableView, "'\(controllerName)' tableview is nil")
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
    
    // Instantiate and test tableView sections/rows count
    //
    func testTableViewSectionsCount() {
        let settingsTableView = controller.tableView
        XCTAssertEqual(controller.numberOfSections(in:settingsTableView!), Int(SETTINGS_MAX_SECTIONS))
        
        for section in 1...SETTINGS_MAX_SECTIONS {
            XCTAssertGreaterThan(controller.tableView.numberOfRows(inSection:Int(section)), 0)
        }
    }

    // Confirm no segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["AboutSegue", "DisclaimerSegue", "UnwindToViewControllerSegue"])
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavSettingsTableViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is SettingsTableViewController, "'\(controllerName)' is embedded in UINavigationController")
    }
    
    // Top Navigation Bar action
    //
    func testDirectActions() {
        // Top Navigation Bar
        //
        XCTAssertTrue(controller.canPerformAction(Selector(("goBack:")), withSender:self))
        XCTAssertTrue(controller.canPerformAction(#selector(NSManagedObjectContext.save), withSender:self))
        
        // TableView Actions
        //
        verifyDirectActions(viewController:controller, actionList:["setDbPollUpdateSwitchState:", "setDbForceUpdateSwitchState:", "setPSSwitchState:", "setMASwitchState:", "tapAreaStepperPressed", "changeShape", "matchNumStepperPressed", "doneWithNumberPad", "setRGBDisplayState", "doneWithTextView", "setAlertsFilterSwitchState:"])
    }
    
    // Unwind Actions
    //
    func testUnwindActions() {
        // Bottom Toolbar (the 'Settings' button has no action)
        //
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from:controller, withSender:self))
    }
}
