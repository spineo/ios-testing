//
//  RGButterflyTests.swift
//  RGButterflyTests
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest

// Static Elements Tests
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// View Controllers exists
// Controller Views/Subviews exist
// ViewController and/or NavController titles are not null
// Buttons exist and have the correct tags
// Toolbar Items Buttons are in the correct order, with correct tag
// Check for buttons state
//
class RGButterflyTests: XCTestCase {
  
    let storyboard    : UIStoryboard    = UIStoryboard(name: "Main", bundle: Bundle.main)
    var view          : UIView          = UIView()
    var tableView     : UITableView     = UITableView()
    var tableViewCell : UITableViewCell = UITableViewCell()
    var scrollView    : UIScrollView    = UIScrollView()
    var imageView     : UIImageView     = UIImageView()
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
        imageLibButton = mainVC.navigationItem.leftBarButtonItem!
        searchButton   = mainVC.navigationItem.rightBarButtonItem!

        toolbarItems    = mainVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        listingButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace2  = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem

        // Views
        //
        XCTAssertNotNil(view)
        XCTAssertNotNil(tableView)
        
        // Nav Buttons
        //
        XCTAssertTrue(imageLibButton.tag == Int(IMAGELIB_BTN_TAG))
        XCTAssertTrue(searchButton.tag == Int(SEARCH_BTN_TAG))
        
        // Titles
        //
        XCTAssertNotNil(mainVC.navigationItem.title!)
        XCTAssertNotNil(mainVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(homeButton.tag     == Int(HOME_BTN_TAG))
        XCTAssertTrue(flexibleSpace.tag  == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(listingButton.tag  == Int(LISTING_BTN_TAG))
        XCTAssertTrue(flexibleSpace2.tag == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(settingsButton.tag == Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(searchButton.isEnabled)
        XCTAssertTrue(imageLibButton.isEnabled)
        XCTAssertTrue(homeButton.isEnabled)
        XCTAssertTrue(listingButton.isEnabled)
        XCTAssertTrue(settingsButton.isEnabled)
    }
    
    // SettingsTableViewController
    //
    func testSettingsViewController() {
        var settingsTVC: SettingsTableViewController = SettingsTableViewController()
        settingsTVC = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        
        backButton = settingsTVC.navigationItem.leftBarButtonItem!
        
        toolbarItems    = settingsTVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(settingsTVC.tableView)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(settingsTVC.navigationItem.title!)
        XCTAssertNotNil(settingsTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(homeButton.tag     == Int(HOME_BTN_TAG))
        XCTAssertTrue(flexibleSpace.tag == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(settingsButton.tag == Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        XCTAssertTrue(homeButton.isEnabled)
        XCTAssertTrue(settingsButton.isEnabled)
    }
    
    // AboutViewController
    //
    func testAboutViewController() {
        var aboutVC: AboutViewController = AboutViewController()
        aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController

        backButton = aboutVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(aboutVC.view)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(aboutVC.navigationItem.title!)
        XCTAssertNotNil(aboutVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // DisclaimerViewController
    //
    func testDisclaimerViewController() {
        var disclaimerVC: DisclaimerViewController = DisclaimerViewController()
        disclaimerVC = storyboard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        
        backButton = disclaimerVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(disclaimerVC.view)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(disclaimerVC.navigationItem.title!)
        XCTAssertNotNil(disclaimerVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // PickerViewController
    //
    func testPickerViewController() {
        var pickerVC: PickerViewController = PickerViewController()
        pickerVC = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        
        backButton = pickerVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(pickerVC.view)
        XCTAssertNotNil(pickerVC.title!)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // UIImageViewController
    //
    func testUIImageViewController() {
        var imageVC: UIImageViewController = UIImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "UIImageViewController") as! UIImageViewController
        
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
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(imageVC.navigationItem.title!)
        XCTAssertNotNil(imageVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(homeButton.tag     == Int(HOME_BTN_TAG))
        XCTAssertTrue(flexibleSpace.tag  == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(decrAlgButton.tag  == Int(DECR_ALG_BTN_TAG))
        XCTAssertTrue(matchButton.tag    == Int(MATCH_BTN_TAG))
        XCTAssertTrue(incrAlgButton.tag  == Int(INCR_ALG_BTN_TAG))
        XCTAssertTrue(viewButton.tag     == Int(VIEW_BTN_TAG))
        XCTAssertTrue(flexibleSpace2.tag == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(decrTapButton.tag  == Int(DECR_TAP_BTN_TAG))
        XCTAssertTrue(incrTapButton.tag  == Int(INCR_TAP_BTN_TAG))
        XCTAssertTrue(settingsButton.tag == Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
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
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(matchTVC.navigationItem.title!)
        XCTAssertNotNil(matchTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(rgbButton.tag      == Int(RGB_BTN_TAG))
        XCTAssertTrue(flexibleSpace.tag  == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(decrAlgButton.tag  == Int(DECR_ALG_BTN_TAG))
        XCTAssertTrue(matchButton.tag    == Int(MATCH_BTN_TAG))
        XCTAssertTrue(incrAlgButton.tag  == Int(INCR_ALG_BTN_TAG))
        XCTAssertTrue(flexibleSpace2.tag == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(decrTapButton.tag  == Int(DECR_TAP_BTN_TAG))
        XCTAssertTrue(fixedSpace.tag     == Int(FIXED_SPACE_TAG))
        XCTAssertTrue(incrTapButton.tag  == Int(INCR_TAP_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
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
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(assocTVC.navigationItem.title!)
        XCTAssertNotNil(assocTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(homeButton.tag     == Int(HOME_BTN_TAG))
        XCTAssertTrue(flexibleSpace.tag  == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(settingsButton.tag == Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // SwatchDetailTableViewController
    //
    func testSwatchDetailTableViewController() {
        var detailTVC: SwatchDetailTableViewController = SwatchDetailTableViewController()
        detailTVC = storyboard.instantiateViewController(withIdentifier: "SwatchDetailTableViewController") as! SwatchDetailTableViewController
        
        tableView  = detailTVC.tableView
        backButton = detailTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(detailTVC.navigationItem.title!)
        XCTAssertNotNil(detailTVC.title!)
        XCTAssertNil(detailTVC.toolbarItems)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    // AddMixTableViewController
    //
    func testAddMixTableViewController() {
        var addMixTVC: AddMixTableViewController = AddMixTableViewController()
        addMixTVC = storyboard.instantiateViewController(withIdentifier: "AddMixTableViewController") as! AddMixTableViewController
        
        tableView  = addMixTVC.tableView
        backButton = addMixTVC.navigationItem.leftBarButtonItem!
        
        toolbarItems  = addMixTVC.toolbarItems!
        flexibleSpace = toolbarItems.removeFirst() as! UIBarButtonItem
        doneButton    = toolbarItems.removeFirst() as! UIBarButtonItem
        
        XCTAssertNotNil(tableView)
        XCTAssertTrue(backButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(addMixTVC.navigationItem.title!)
        XCTAssertNotNil(addMixTVC.title!)
        
        // Toolbar Items
        //
        XCTAssertTrue(flexibleSpace.tag  == Int(FLEXIBLE_SPACE_TAG))
        XCTAssertTrue(doneButton.tag     == Int(DONE_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
