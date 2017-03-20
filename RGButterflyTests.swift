//
//  RGButterflyTests.swift
//  RGButterflyTests - RGButterfly Tests Main Class
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest


class RGButterflyTests: XCTestCase {
  
    let storyboard    : UIStoryboard    = UIStoryboard(name: "Main", bundle: Bundle.main)
    var view          : UIView          = UIView()
    var tableView     : UITableView     = UITableView()
    var tableViewCell : UITableViewCell = UITableViewCell()
    var scrollView    : UIScrollView    = UIScrollView()
    var imageView     : UIImageView     = UIImageView()
    var titleView     : UIView          = UIView()
    var searchBar     : UISearchBar     = UISearchBar()
    var cancelButton  : UIButton        = UIButton()
    var imageLibButton: UIBarButtonItem = UIBarButtonItem()
    var backButton    : UIBarButtonItem = UIBarButtonItem()
    var searchButton  : UIBarButtonItem = UIBarButtonItem()
    var toolbar       : UIToolbar       = UIToolbar()
    var toolbarItems  : [AnyObject]     = [AnyObject]()
    var homeButton    : UIBarButtonItem = UIBarButtonItem()
    var listingButton : UIBarButtonItem = UIBarButtonItem()
    var settingsButton: UIBarButtonItem = UIBarButtonItem()
    var decrAlgButton : UIBarButtonItem = UIBarButtonItem()
    var matchButton   : UIBarButtonItem = UIBarButtonItem()
    var incrAlgButton : UIBarButtonItem = UIBarButtonItem()
    var viewButton    : UIBarButtonItem = UIBarButtonItem()
    var decrTapButton : UIBarButtonItem = UIBarButtonItem()
    var incrTapButton : UIBarButtonItem = UIBarButtonItem()
    var rgbButton     : UIBarButtonItem = UIBarButtonItem()
    var doneButton    : UIBarButtonItem = UIBarButtonItem()

    var flexibleSpace : UIBarButtonItem = UIBarButtonItem()
    var flexibleSpace2: UIBarButtonItem = UIBarButtonItem()
    var fixedSpace    : UIBarButtonItem = UIBarButtonItem()

    var entityCount   : Int             = Int()
    var fileCount     : Int             = Int()
    var dict_id       : Int             = Int()
    var type_id       : Int             = Int()
    
    // UserDefaults
    //
    var userDefaults  : UserDefaults    = UserDefaults()
    var pollUpdate    : Bool            = Bool()
    
    // CoreDataUtils
    //
    var objects       = [AnyObject]()
    var objSet        : NSSet             = NSSet()
    var objArray      = [AnyObject]()
    var objName       : String            = String()
    var swatchType    : PaintSwatchType   = PaintSwatchType()
    var mixAssoc      : MixAssociation    = MixAssociation()
    var paintSwatch   : PaintSwatches     = PaintSwatches()
    var assocSwatches = [MixAssocSwatch]()
    var tapAreas      = [TapArea]()
 
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
