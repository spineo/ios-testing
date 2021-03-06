//
//  RGButterflyTests.swift
//  RGButterflyBaseTests - RGButterfly Base Tests Class contains common testing methods
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest


class RGButterflyBaseTests: XCTestCase {
  
    let storyboard    : UIStoryboard    = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    // UserDefaults
    //
    var userDefaults  : UserDefaults    = UserDefaults()
    var pollUpdate    : Bool            = Bool()
 
    override func setUp() {
        super.setUp()

        userDefaults      = UserDefaults.standard
        backupUserDefaults()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        restoreUserDefaults()
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Supporting methods
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    
    // Backup UserDefaults
    //
    func backupUserDefaults() {
        pollUpdate = userDefaults.bool(forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Restore UserDefaults
    //
    func restoreUserDefaults() {
        userDefaults.setValue(pollUpdate, forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Test for segues
    //
    func runSeguesTests(viewController:UIViewController, seguesList:[String]) {
        let identifiers = getSeguesIdentifiers(viewController:viewController)
        XCTAssertEqual(identifiers.count, seguesList.count, "Segue count")
        for segue in seguesList {
            XCTAssertTrue(identifiers.contains(segue), "Segue identifier should exist.")
        }
    }
    
    // Segues check
    //
    func getSeguesIdentifiers(viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as?
            [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
    // Verify that selector actions can be invoked
    //
    func verifyDirectActions(viewController:UIViewController, actionList:[String]) {
        for action in actionList {
            XCTAssertTrue(viewController.canPerformAction(Selector((action)), withSender:self), "Action '\(action)' failed.")
        }
    }
    
    // Verify that collection views are associated with specific tableView cells (i.e., Match/Mix)
    // and each collection view contains more than zero items
    //
    func verifyCollectionView(viewController:MainViewController, tableView:UITableView, listingType:String) {
        viewController.listingType = listingType
        viewController.loadData()

        let maxIndex = viewController.tableView(tableView, numberOfRowsInSection:0) - 1
        for row in 0...maxIndex {
            let refIndexPath = NSIndexPath(row:row, section:0)
            let cell = viewController.tableView(tableView, cellForRowAt:refIndexPath as IndexPath)
            let subviews = (cell.contentView).subviews
            for view in subviews {
                if view is UICollectionView {
                    let collectionView = view as! UICollectionView
                    XCTAssertGreaterThan(collectionView.numberOfSections, 0)
                    XCTAssertGreaterThan(collectionView.numberOfItems(inSection:0), 0)
                }
            }
        }
    }
}
