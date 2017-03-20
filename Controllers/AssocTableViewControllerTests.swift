//
//  AssocTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AssocTableViewControllerTests: RGButterflyBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // AssocTableViewController
    //
    func testAssocTableViewController() {
        var assocTVC: AssocTableViewController = AssocTableViewController()
        assocTVC = storyboard.instantiateViewController(withIdentifier: "AssocTableViewController") as! AssocTableViewController
        
        tableView  = assocTVC.tableView
        backButton = assocTVC.navigationItem.leftBarButtonItem!
        
        toolbarItems    = assocTVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(tableView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(assocTVC.navigationItem.title!)
        XCTAssertNotNil(assocTVC.title!)
        
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
        
        // Test for segues
        //
        runSeguesTests(viewController:assocTVC, seguesList:["AddMixSegue", "AssocSwatchDetailSegue",
                                                            "unwindToImageViewFromAssoc", "unwindToVC", "SettingsSegue"])
        
        // Test the NavigationController
        //
        var assocNC: UINavigationController = UINavigationController()
        assocNC = storyboard.instantiateViewController(withIdentifier: "NavAssocTableViewController") as! UINavigationController
        XCTAssertTrue(assocNC.topViewController is AssocTableViewController, "AssocTableViewController is embedded in UINavigationController")
        
        // Test actions
        //
        // NavBar
        //
        var imageVC: ImageViewController = ImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        XCTAssertTrue(imageVC.canPerformUnwindSegueAction(Selector(("unwindToImageViewFromAssoc:")), from:assocTVC, withSender:self))
        
        // Internal Views
        //
        verifyDirectActions(viewController:assocTVC, actionList:["showAssocTypePicker", "showCoveragePicker", "showMixRatiosPicker", "applyRenaming", "ratiosSelection", "assocTypeSelection", "coverageSelection"])
        
        // Toolbar ('Settings' button is a segue)
        //
        var mainVC: MainViewController = MainViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from:assocTVC, withSender:self))
    }
}
