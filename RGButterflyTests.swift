//
//  RGButterflyTests.swift
//  RGButterflyTests
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest

// Basic Tests
// View Controllers exists
// Controller Views/Subviews exist
// ViewController and/or NavController titles are not null
// Buttons exist and have the correct tags
//
class RGButterflyTests: XCTestCase {
  
    let storyboard    : UIStoryboard    = UIStoryboard(name: "Main", bundle: Bundle.main)
    var view          : UIView          = UIView()
    var tableView     : UITableView     = UITableView()
    var tableViewCell : UITableViewCell = UITableViewCell()
    var scrollView    : UIScrollView    = UIScrollView()
    var imageView     : UIImageView     = UIImageView()
    var topLeftButton : UIBarButtonItem = UIBarButtonItem()
    var topRightButton: UIBarButtonItem = UIBarButtonItem()
    var toolbar       : UIToolbar       = UIToolbar()
    var toolbarItems  : [AnyObject]     = [AnyObject]()
    var homeButton    : UIBarButtonItem = UIBarButtonItem()
    var listingButton : UIBarButtonItem = UIBarButtonItem()
    var settingsButton: UIBarButtonItem = UIBarButtonItem()
    
    var hasView      : Bool = Bool()
    var subviewsCount: Int  = Int()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // InitViewController Unit Tests
    //
    func testInitViewController() {
        var initVC: InitViewController = InitViewController()
        initVC = storyboard.instantiateInitialViewController() as! InitViewController
        
        view = initVC.view
        
        XCTAssertNotNil(view)
        XCTAssertNotNil(initVC.title!)
    }
    
    // Main ViewController Unit Tests
    //
    func testViewController() {
        var mainVC: ViewController = ViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        // The views, navigation items and toolbar item title and buttons
        //
        view           = mainVC.view
        tableView      = view.subviews.first as! UITableView
        topLeftButton  = mainVC.navigationItem.leftBarButtonItem!
        topRightButton = mainVC.navigationItem.rightBarButtonItem!

        toolbarItems    = mainVC.toolbarItems!
        settingsButton   = toolbarItems.popLast() as! UIBarButtonItem
        toolbarItems.popLast()
        listingButton    = toolbarItems.popLast() as! UIBarButtonItem
        toolbarItems.popLast()
        homeButton       = toolbarItems.popLast() as! UIBarButtonItem
        

        // Views
        //
        XCTAssertNotNil(view)
        XCTAssertNotNil(tableView)
        
        // Nav Buttons
        //
        XCTAssertTrue(topLeftButton.tag == Int(IMAGELIB_BTN_TAG))
        XCTAssertTrue(topRightButton.tag == Int(SEARCH_BTN_TAG))
        
        // Titles
        //
        XCTAssertNotNil(mainVC.navigationItem.title!)
        XCTAssertNotNil(mainVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(homeButton.tag     == Int(HOME_BTN_TAG))
        XCTAssertTrue(listingButton.tag  == Int(LISTING_BTN_TAG))
        XCTAssertTrue(settingsButton.tag == Int(SETTINGS_BTN_TAG))
    }
    
    // SettingsTableViewController
    //
    func testSettingsViewController() {
        var settingsTVC: SettingsTableViewController = SettingsTableViewController()
        settingsTVC = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        
        topLeftButton = settingsTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(settingsTVC.tableView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(settingsTVC.navigationItem.title!)
        XCTAssertNotNil(settingsTVC.title!)
    }
    
    // AboutViewController
    //
    func testAboutViewController() {
        var aboutVC: AboutViewController = AboutViewController()
        aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController

        topLeftButton = aboutVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(aboutVC.view)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(aboutVC.navigationItem.title!)
        XCTAssertNotNil(aboutVC.title!)
    }
    
    // AboutViewController
    //
    func testDisclaimerViewController() {
        var disclaimerVC: DisclaimerViewController = DisclaimerViewController()
        disclaimerVC = storyboard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        
        topLeftButton = disclaimerVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(disclaimerVC.view)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(disclaimerVC.navigationItem.title!)
        XCTAssertNotNil(disclaimerVC.title!)
    }
    
    // PickerViewController
    //
    func testPickerViewController() {
        var pickerVC: PickerViewController = PickerViewController()
        pickerVC = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController

        XCTAssertNotNil(pickerVC.view)
        XCTAssertNotNil(pickerVC.title!)
    }
    
    // UIImageViewController
    //
    func testUIImageViewController() {
        var imageVC: UIImageViewController = UIImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "UIImageViewController") as! UIImageViewController
        
        view          = imageVC.view
        tableView     = view.viewWithTag(Int(TABLEVIEW_TAG))  as! UITableView
        scrollView    = view.viewWithTag(Int(SCROLLVIEW_TAG)) as! UIScrollView
        imageView     = view.viewWithTag(Int(IMAGEVIEW_TAG))  as! UIImageView
        topLeftButton = imageVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(view)
        XCTAssertNotNil(tableView)
        XCTAssertNotNil(scrollView)
        XCTAssertNotNil(imageView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(imageVC.navigationItem.title!)
        XCTAssertNotNil(imageVC.title!)
    }
    
    // MatchTableViewController
    //
    func testMatchTableViewController() {
        var matchTVC: MatchTableViewController = MatchTableViewController()
        matchTVC = storyboard.instantiateViewController(withIdentifier: "MatchTableViewController") as! MatchTableViewController

        tableView     = matchTVC.tableView
        topLeftButton = matchTVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(tableView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(matchTVC.navigationItem.title!)
        XCTAssertNotNil(matchTVC.title!)
    }
    
    // AssocTableViewController
    //
    func testAssocTableViewController() {
        var assocTVC: AssocTableViewController = AssocTableViewController()
        assocTVC = storyboard.instantiateViewController(withIdentifier: "AssocTableViewController") as! AssocTableViewController
        
        tableView     = assocTVC.tableView
        topLeftButton = assocTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(assocTVC.navigationItem.title!)
        XCTAssertNotNil(assocTVC.title!)
    }
    
    // SwatchDetailTableViewController
    //
    func testSwatchDetailTableViewController() {
        var detailTVC: SwatchDetailTableViewController = SwatchDetailTableViewController()
        detailTVC = storyboard.instantiateViewController(withIdentifier: "SwatchDetailTableViewController") as! SwatchDetailTableViewController
        
        tableView     = detailTVC.tableView
        topLeftButton = detailTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(detailTVC.navigationItem.title!)
        XCTAssertNotNil(detailTVC.title!)
    }
    
    // AddMixTableViewController
    //
    func testAddMixTableViewController() {
        var addMixTVC: AddMixTableViewController = AddMixTableViewController()
        addMixTVC = storyboard.instantiateViewController(withIdentifier: "AddMixTableViewController") as! AddMixTableViewController
        
        tableView     = addMixTVC.tableView
        topLeftButton = addMixTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(addMixTVC.navigationItem.title!)
        XCTAssertNotNil(addMixTVC.title!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
