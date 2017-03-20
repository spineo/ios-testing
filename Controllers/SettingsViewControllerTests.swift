//
//  SettingsViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class SettingsViewControllerTests: RGButterflyBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // SettingsTableViewController
    //
    func testSettingsViewController() {
        var settingsTVC: SettingsTableViewController = SettingsTableViewController()
        settingsTVC = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        settingsTVC.viewDidLoad()
        
        backButton = settingsTVC.navigationItem.leftBarButtonItem!
        
        toolbarItems    = settingsTVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(settingsTVC.tableView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(settingsTVC.navigationItem.title!)
        XCTAssertNotNil(settingsTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertEqual(homeButton.tag,     Int(HOME_BTN_TAG))
        XCTAssertEqual(flexibleSpace.tag,  Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(settingsButton.tag, Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        XCTAssertTrue(homeButton.isEnabled)
        XCTAssertTrue(settingsButton.isEnabled)
        
        // Instantiate and test tableView sections/rows count
        //
        let settingsTableView = settingsTVC.tableView
        XCTAssertEqual(settingsTVC.numberOfSections(in:settingsTableView!), Int(SETTINGS_MAX_SECTIONS))
        
        for section in 1...SETTINGS_MAX_SECTIONS {
            XCTAssertGreaterThan(settingsTVC.tableView.numberOfRows(inSection:Int(section)), 0)
        }
        
        // Test for segues
        //
        runSeguesTests(viewController:settingsTVC, seguesList:["AboutSegue", "DisclaimerSegue", "UnwindToViewControllerSegue"])
        
        // Test the NavigationController
        //
        var settingsNC: UINavigationController = UINavigationController()
        settingsNC = storyboard.instantiateViewController(withIdentifier: "NavSettingsTableViewController") as! UINavigationController
        XCTAssertTrue(settingsNC.topViewController is SettingsTableViewController, "SettingsTableViewController is embedded in UINavigationController")
        
        // Test selectors/actions
        //
        // Top Navigation Bar
        //
        XCTAssertTrue(settingsTVC.canPerformAction(Selector(("goBack:")), withSender:self))
        XCTAssertTrue(settingsTVC.canPerformAction(#selector(NSManagedObjectContext.save), withSender:self))
        
        // TableView Actions
        //
        verifyDirectActions(viewController:settingsTVC, actionList:["setDbPollUpdateSwitchState:", "setDbForceUpdateSwitchState:", "setPSSwitchState:", "setMASwitchState:", "tapAreaStepperPressed", "changeShape", "matchNumStepperPressed", "doneWithNumberPad", "setRGBDisplayState", "doneWithTextView", "setAlertsFilterSwitchState:"])

        // Bottom Toolbar (the 'Settings' button has no action)
        //
        var mainVC: MainViewController = MainViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from:settingsTVC, withSender:self))
    }
}
