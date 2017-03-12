//
//  MatchTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class MatchTableViewControllerTests: RGButterflyTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MatchTableViewController
    //
    func testMatchTableViewController() {
        var matchTVC: MatchTableViewController = MatchTableViewController()
        matchTVC = storyboard.instantiateViewController(withIdentifier: "MatchTableViewController") as! MatchTableViewController
        
        tableView  = matchTVC.tableView
        backButton = matchTVC.navigationItem.leftBarButtonItem!
        
        toolbarItems    = matchTVC.toolbarItems!
        rgbButton       = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        decrAlgButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        matchButton     = toolbarItems.removeFirst() as! UIBarButtonItem
        incrAlgButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace2  = toolbarItems.removeFirst() as! UIBarButtonItem
        decrTapButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        fixedSpace      = toolbarItems.removeFirst() as! UIBarButtonItem
        incrTapButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(tableView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(matchTVC.navigationItem.title!)
        XCTAssertNotNil(matchTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertEqual(rgbButton.tag,      Int(RGB_BTN_TAG))
        XCTAssertEqual(flexibleSpace.tag,  Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(decrAlgButton.tag,  Int(DECR_ALG_BTN_TAG))
        XCTAssertEqual(matchButton.tag,    Int(MATCH_BTN_TAG))
        XCTAssertEqual(incrAlgButton.tag,  Int(INCR_ALG_BTN_TAG))
        XCTAssertEqual(flexibleSpace2.tag, Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(decrTapButton.tag,  Int(DECR_TAP_BTN_TAG))
        XCTAssertEqual(fixedSpace.tag,     Int(FIXED_SPACE_TAG))
        XCTAssertEqual(incrTapButton.tag,  Int(INCR_TAP_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        XCTAssertTrue(rgbButton.isEnabled)
        XCTAssertTrue(decrAlgButton.isEnabled)
        XCTAssertTrue(matchButton.isEnabled)
        XCTAssertTrue(incrAlgButton.isEnabled)
        XCTAssertFalse(decrTapButton.isEnabled)
        XCTAssertFalse(incrTapButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:matchTVC, seguesList:["unwindToImageViewFromMatch", "ShowSwatchDetailSegue", "unwindToImageViewFromMatch"])
        
        // Test the NavigationController
        //
        var matchNC: UINavigationController = UINavigationController()
        matchNC = storyboard.instantiateViewController(withIdentifier: "NavMatchTableViewController") as! UINavigationController
        XCTAssertTrue(matchNC.topViewController is MatchTableViewController, "MatchTableViewController is embedded in UINavigationController")
        
        // Test actions
        //
        // NavBar
        //
        var imageVC: UIImageViewController = UIImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "UIImageViewController") as! UIImageViewController
        XCTAssertTrue(imageVC.canPerformUnwindSegueAction(Selector(("unwindToImageViewFromMatch:")), from:matchTVC, withSender:self))
        
        // Internal Views
        //
        verifyDirectActions(viewController:matchTVC, actionList:["pressCell:"])
        
        // Toolbar
        //
        verifyDirectActions(viewController:matchTVC, actionList:["toggleRGB:", "decr:", "toggleAction:", "incr:", "removeTableRows:", "addTableRows:"])
    }
}
