//
//  ImageViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class ImageViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "ImageViewController"
    var controller: ImageViewController = ImageViewController()
    
    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! ImageViewController
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
    
    // Controller title
    //
    func testControllerTitle() {
        XCTAssertNotNil(controller.title!)
    }
    
    // Main View
    //
    func testMainView() {
        XCTAssertNotNil(controller.view)
    }
    
    // TableView
    //
    func testTableView() {
        let tableView  = controller.view.viewWithTag(Int(TABLEVIEW_TAG))  as! UITableView
        XCTAssertNotNil(tableView, "'\(controllerName)' tableview is nil")
    }
    
    // ScrollView
    //
    func testScrollView() {
        let scrollView = controller.view.viewWithTag(Int(SCROLLVIEW_TAG)) as! UIScrollView
        XCTAssertNotNil(scrollView, "'\(controllerName)' scrollview is nil")
    }
    
    // ImageView
    //
    func testImageView() {
        let imageView = controller.view.viewWithTag(Int(IMAGEVIEW_TAG))  as! UIImageView
        XCTAssertNotNil(imageView, "'\(controllerName)' imageview is nil")
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
        
        let decrAlgButton   = toolbarItems.removeFirst()
        XCTAssertEqual(decrAlgButton.tag, Int(DECR_ALG_BTN_TAG))
        XCTAssertFalse(decrAlgButton.isEnabled)

        let matchButton     = toolbarItems.removeFirst()
        XCTAssertEqual(matchButton.tag,   Int(MATCH_BTN_TAG))
        XCTAssertTrue(matchButton.isEnabled)
        
        let incrAlgButton   = toolbarItems.removeFirst()
        XCTAssertEqual(incrAlgButton.tag, Int(INCR_ALG_BTN_TAG))
        XCTAssertFalse(incrAlgButton.isEnabled)
        
        let viewButton      = toolbarItems.removeFirst()
        XCTAssertEqual(viewButton.tag,    Int(VIEW_BTN_TAG))
        XCTAssertFalse(viewButton.isEnabled)
        
        let flexibleSpace2  = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace2.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let decrTapButton   = toolbarItems.removeFirst()
        XCTAssertEqual(decrTapButton.tag, Int(DECR_TAP_BTN_TAG))
        XCTAssertFalse(decrTapButton.isEnabled)
        
        let incrTapButton   = toolbarItems.removeFirst()
        XCTAssertEqual(incrTapButton.tag, Int(INCR_TAP_BTN_TAG))
        XCTAssertFalse(incrTapButton.isEnabled)
        
        let settingsButton = toolbarItems.removeFirst()
        XCTAssertEqual(settingsButton.tag, Int(SETTINGS_BTN_TAG))
        XCTAssertTrue(settingsButton.isEnabled)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["AssocTableViewSegue", "AssocToDetailSegue",
                                                              "MatchTableViewSegue", "unwindToVCSegue", "SettingsSegue"])
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavImageViewController") as! ImageViewNavigationController
        XCTAssertTrue(navController.topViewController is ImageViewController, "'\(controller)' is embedded in ImageViewNavigationController")
    }
    
    // Test Unwind Actions
    //
    func testUnwindActions() {
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from: controller, withSender:self))
    }
    
    // Test direct actions
    //
    func testDirectActions() {
        // NavBar
        //
        verifyDirectActions(viewController:controller, actionList:["goBack:", "editAlertShow:"])

        // View internal
        //
        verifyDirectActions(viewController:controller, actionList:["respondToTap:", "respondToPinch:", "handleLongPress:", "moveTapArea:", "selectMatchAction", "selectAssocAction", "scrollViewIncrease", "scrollViewDecrease"])
        
        // Toolbar
        //
        verifyDirectActions(viewController:controller, actionList:["decrMatchAlgorithm:", "showTypeOptions:", "incrMatchAlgorithm:", "segueToMatchOrAssoc:"])
    }
    
    // Test the IBOutlets
    //
    func testIBOutlets() {
        XCTAssertNotNil(controller.imageScrollView, "IBOutlet 'imageScrollView' is nil")
        XCTAssertNotNil(controller.imageView, "IBOutlet 'imageView' is nil")
        XCTAssertNotNil(controller.imageTableView, "IBOutlet 'imageTableView' is nil")
    }
    
    // Test the Delegates
    //
    func testDelegates() {
        XCTAssertTrue(controller.imageScrollView.delegate is UIImagePickerControllerDelegate)
        XCTAssertTrue(controller.imageTableView.delegate is UIScrollViewDelegate)
        XCTAssertTrue(controller.imageScrollView.delegate is UITableViewDelegate)
        XCTAssertTrue(controller.imageScrollView.delegate is UITableViewDataSource)
        XCTAssertTrue(controller.imageTableView.delegate is UICollectionViewDataSource)
        XCTAssertTrue(controller.imageTableView.delegate is UICollectionViewDelegate)
    }
}
