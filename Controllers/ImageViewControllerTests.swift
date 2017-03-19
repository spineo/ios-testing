//
//  ImageViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class ImageViewControllerTests: RGButterflyTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // ImageViewController
    //
    func testImageViewController() {
        var imageVC: ImageViewController = ImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        view            = imageVC.view
        tableView       = view.viewWithTag(Int(TABLEVIEW_TAG))  as! UITableView
        scrollView      = view.viewWithTag(Int(SCROLLVIEW_TAG)) as! UIScrollView
        imageView       = view.viewWithTag(Int(IMAGEVIEW_TAG))  as! UIImageView
        backButton      = imageVC.navigationItem.leftBarButtonItem!
        
        toolbarItems    = imageVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        decrAlgButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        matchButton     = toolbarItems.removeFirst() as! UIBarButtonItem
        incrAlgButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        viewButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace2  = toolbarItems.removeFirst() as! UIBarButtonItem
        decrTapButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        incrTapButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(view)
        XCTAssertNotNil(tableView)
        XCTAssertNotNil(scrollView)
        XCTAssertNotNil(imageView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(imageVC.navigationItem.title!)
        XCTAssertNotNil(imageVC.title!)
        
        // Toolbar Items
        //
        XCTAssertEqual(homeButton.tag,    Int(HOME_BTN_TAG))
        XCTAssertEqual(flexibleSpace.tag, Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(decrAlgButton.tag, Int(DECR_ALG_BTN_TAG))
        XCTAssertEqual(matchButton.tag,   Int(MATCH_BTN_TAG))
        XCTAssertEqual(incrAlgButton.tag, Int(INCR_ALG_BTN_TAG))
        XCTAssertEqual(viewButton.tag,    Int(VIEW_BTN_TAG))
        XCTAssertEqual(flexibleSpace2.tag,Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(decrTapButton.tag, Int(DECR_TAP_BTN_TAG))
        XCTAssertEqual(incrTapButton.tag, Int(INCR_TAP_BTN_TAG))
        XCTAssertEqual(settingsButton.tag,Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        XCTAssertTrue(homeButton.isEnabled)
        XCTAssertFalse(decrAlgButton.isEnabled)
        XCTAssertTrue(matchButton.isEnabled)
        XCTAssertFalse(incrAlgButton.isEnabled)
        XCTAssertFalse(viewButton.isEnabled)
        XCTAssertFalse(decrTapButton.isEnabled)
        XCTAssertFalse(incrTapButton.isEnabled)
        XCTAssertTrue(settingsButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:imageVC, seguesList:["AssocTableViewSegue", "AssocToDetailSegue",
                                                           "MatchTableViewSegue", "unwindToVCSegue", "SettingsSegue"])
        
        // Test the NavigationController
        //
        var imageNC: ImageViewNavigationController = ImageViewNavigationController()
        imageNC = storyboard.instantiateViewController(withIdentifier: "NavImageViewController") as! ImageViewNavigationController
        XCTAssertTrue(imageNC.topViewController is ImageViewController, "ImageViewController is embedded in ImageViewNavigationController")
        
        // Test actions
        //
        // NavBar
        //
        verifyDirectActions(viewController:imageVC, actionList:["goBack:", "editAlertShow:"])
        
        // View internal
        //
        verifyDirectActions(viewController:imageVC, actionList:["respondToTap:", "respondToPinch:", "handleLongPress:", "moveTapArea:", "selectMatchAction", "selectAssocAction", "scrollViewIncrease", "scrollViewDecrease"])
        
        // Toolbar ('View' and 'Settings' are segues)
        //
        var mainVC: MainViewController = MainViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        XCTAssertTrue(mainVC.canPerformUnwindSegueAction(#selector(MainViewController.unwind(toViewController:)), from:imageVC, withSender:self))
        verifyDirectActions(viewController:imageVC, actionList:["decrMatchAlgorithm:", "showTypeOptions:", "incrMatchAlgorithm:", "segueToMatchOrAssoc:"])
        // Disabled: "removeTableRows:" and "addTableRows:"

        
        // Test the IBOutlets
        //
        XCTAssertNotNil(imageVC.imageScrollView, "IBOutlet 'imageScrollView' is nil")
        XCTAssertNotNil(imageVC.imageView, "IBOutlet 'imageView' is nil")
        XCTAssertNotNil(imageVC.imageTableView, "IBOutlet 'imageTableView' is nil")
    }
}
