//
//  AddMixTableViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class AddMixTableViewControllerTests: RGButterflyTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // AddMixTableViewController
    //
    func testAddMixTableViewController() {
        var addMixTVC: AddMixTableViewController = AddMixTableViewController()
        addMixTVC = storyboard.instantiateViewController(withIdentifier: "AddMixTableViewController") as! AddMixTableViewController
        
        tableView    = addMixTVC.tableView
        backButton   = addMixTVC.navigationItem.leftBarButtonItem!
        searchButton = addMixTVC.navigationItem.rightBarButtonItem!
        
        toolbarItems  = addMixTVC.toolbarItems!
        flexibleSpace = toolbarItems.removeFirst() as! UIBarButtonItem
        doneButton    = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(tableView)
        XCTAssertEqual(backButton.tag,   Int(BACK_BTN_TAG))
        XCTAssertEqual(searchButton.tag, Int(SEARCH_BTN_TAG))
        XCTAssertNotNil(addMixTVC.navigationItem.title!)
        XCTAssertNotNil(addMixTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertEqual(flexibleSpace.tag, Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(doneButton.tag,    Int(DONE_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        XCTAssertTrue(searchButton.isEnabled)
        XCTAssertFalse(doneButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:addMixTVC, seguesList:["unwindToAssocFromAdd1", "unwindToAssocFromAdd2",
                                                             "unwindToAssocFromAdd3"])
        
        // Test the NavigationController
        //
        var addMixNC: UINavigationController = UINavigationController()
        addMixNC = storyboard.instantiateViewController(withIdentifier: "NavAddMixTableViewController") as! UINavigationController
        XCTAssertTrue(addMixNC.topViewController is AddMixTableViewController, "AddMixTableViewController is embedded in UINavigationController")
    }
}
