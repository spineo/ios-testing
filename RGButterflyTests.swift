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
// Check for buttons enabled state
// Segues identifiers
// NavigationControllers identifiers
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
    
    // Requirements flags
    //
    var netConnect    : Bool            = Bool()
    var restConnect   : Bool            = Bool()
    
    // UserDefaults
    //
    var userDefaults  : UserDefaults    = UserDefaults()

    var pollUpdate    : Bool            = Bool()


    override func setUp() {
        super.setUp()
        
        // Check the requirements
        //
        if (!HTTPUtils.networkIsReachable()) {
            XCTFail("No network connectivty")
        }
    
        if (!HTTPUtils.urlIsReachable(DB_ROOT_URL)) {
            XCTFail("No REST API connectivty")
        }

        userDefaults      = UserDefaults.standard
        
        backupUserDefaults()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        restoreUserDefaults()
    }
    
    // InitViewController Unit Tests
    //
    func testInitViewController_pollUpdate() {
        var initVC: InitViewController = InitViewController()
        initVC = storyboard.instantiateInitialViewController() as! InitViewController
        
        userDefaults.setValue(true, forKey:DB_POLL_UPDATE_KEY)
        
        initVC.viewDidLoad()
        initVC.viewDidAppear(true)
        
        view = initVC.view
        
        XCTAssertNotNil(view)
        XCTAssertNotNil(initVC.title!)
        
        // Test for segues
        //
        runSeguesTests(viewController:initVC, seguesList:["InitViewControllerSegue"])
        
        
        // Test the background image (currently fails)
        //
        //XCTAssertEqual(view.backgroundColor, UIColor(patternImage: UIImage(named:BACKGROUND_IMAGE_TITLE)!))
        
        // Check the update label and spinner initial states
        //
        let updateLabel = view.viewWithTag(Int(INIT_LABEL_TAG)) as? UILabel
        XCTAssertEqual(updateLabel?.text, SPINNER_LABEL_LOAD, "Initial spinner label")

        let spinner     = view.viewWithTag(Int(INIT_SPINNER_TAG)) as? UIActivityIndicatorView
        XCTAssert((spinner?.isAnimating)!, "Spinner active")

        // Final state
        //
        initVC.viewWillDisappear(true)
        XCTAssertFalse((spinner?.isAnimating)!, "Spinner inactive")
        
        // Need to invoke the UIAlertController actions (states for initVC.updateStat)
    }
    
    // InitViewController Unit Tests (without pollUpdate, all dynamic checks are skipped)
    // Static checks were performed in the preceding testInitViewController_pollUpdate
    //
    func testInitViewController_NoPollUpdate() {
        var initVC: InitViewController = InitViewController()
        initVC = storyboard.instantiateInitialViewController() as! InitViewController
        
        userDefaults.setValue(false, forKey:DB_POLL_UPDATE_KEY)
        
        initVC.viewDidLoad()
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
        XCTAssertEqual(imageLibButton.tag, Int(IMAGELIB_BTN_TAG))
        XCTAssertEqual(searchButton.tag,   Int(SEARCH_BTN_TAG))
        
        // Titles
        //
        XCTAssertNotNil(mainVC.navigationItem.title!)
        XCTAssertNotNil(mainVC.title!)
        
        // Toolbar Items
        //
        XCTAssertEqual(homeButton.tag,     Int(HOME_BTN_TAG))
        XCTAssertEqual(flexibleSpace.tag,  Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(listingButton.tag,  Int(LISTING_BTN_TAG))
        XCTAssertEqual(flexibleSpace2.tag, Int(FLEXIBLE_SPACE_TAG))
        XCTAssertEqual(settingsButton.tag, Int(SETTINGS_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(searchButton.isEnabled)
        XCTAssertTrue(imageLibButton.isEnabled)
        XCTAssertTrue(homeButton.isEnabled)
        XCTAssertTrue(listingButton.isEnabled)
        XCTAssertTrue(settingsButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:mainVC, seguesList:["MainSwatchDetailSegue", "VCToAssocSegue", "ImagePickerSegue", "ImageSelectionSegue", "SettingsSegue"])
        
        // Test the NavigationController
        //
        var mainNC: UINavigationController = UINavigationController()
        mainNC = storyboard.instantiateViewController(withIdentifier: "NavViewController") as! UINavigationController
        XCTAssertTrue(mainNC.topViewController is ViewController, "ViewController is embedded in UINavigationController")
        
        // Test the delegates
        //
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
        
        // Test for segues
        //
        runSeguesTests(viewController:settingsTVC, seguesList:["AboutSegue", "DisclaimerSegue", "UnwindToViewControllerSegue"])
        
        // Test the NavigationController
        //
        var settingsNC: UINavigationController = UINavigationController()
        settingsNC = storyboard.instantiateViewController(withIdentifier: "NavSettingsTableViewController") as! UINavigationController
        XCTAssertTrue(settingsNC.topViewController is SettingsTableViewController, "SettingsTableViewController is embedded in UINavigationController")
    }
    
    // AboutViewController
    //
    func testAboutViewController() {
        var aboutVC: AboutViewController = AboutViewController()
        aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController

        backButton = aboutVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(aboutVC.view)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(aboutVC.navigationItem.title!)
        XCTAssertNotNil(aboutVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        let identifiers = getSeguesIdentifiers(viewController:aboutVC)
        XCTAssertEqual(identifiers.count, 0, "Segue count")
        
        // Test the NavigationController
        //
        var aboutNC: UINavigationController = UINavigationController()
        aboutNC = storyboard.instantiateViewController(withIdentifier: "NavAboutViewController") as! UINavigationController
        XCTAssertTrue(aboutNC.topViewController is AboutViewController, "AboutViewController is embedded in UINavigationController")
    }
    
    // DisclaimerViewController
    //
    func testDisclaimerViewController() {
        var disclaimerVC: DisclaimerViewController = DisclaimerViewController()
        disclaimerVC = storyboard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        
        backButton = disclaimerVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(disclaimerVC.view)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(disclaimerVC.navigationItem.title!)
        XCTAssertNotNil(disclaimerVC.title!)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        let identifiers = getSeguesIdentifiers(viewController:disclaimerVC)
        XCTAssertEqual(identifiers.count, 0, "Segue count")
        
        // Test the NavigationController
        //
        var disclaimerNC: UINavigationController = UINavigationController()
        disclaimerNC = storyboard.instantiateViewController(withIdentifier: "NavDisclaimerViewController") as! UINavigationController
        XCTAssertTrue(disclaimerNC.topViewController is DisclaimerViewController, "DisclaimerViewController is embedded in UINavigationController")
    }
    
    // PickerViewController
    //
    func testPickerViewController() {
        var pickerVC: PickerViewController = PickerViewController()
        pickerVC = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        
        backButton = pickerVC.navigationItem.leftBarButtonItem!

        XCTAssertNotNil(pickerVC.view)
        XCTAssertNotNil(pickerVC.title!)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:pickerVC, seguesList:["ImageViewSegue"])
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
        runSeguesTests(viewController:imageVC, seguesList:["AssocTableViewSegue", "AssocToDetailSegue", "MatchTableViewSegue", "unwindToVCSegue", "SettingsSegue"])
        
        // Test the NavigationController
        //
        var imageNC: UIImageViewNavigationController = UIImageViewNavigationController()
        imageNC = storyboard.instantiateViewController(withIdentifier: "NavUIImageViewController") as! UIImageViewNavigationController
        XCTAssertTrue(imageNC.topViewController is UIImageViewController, "UIImageViewController is embedded in UIImageViewNavigationController")
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
        runSeguesTests(viewController:assocTVC, seguesList:["AddMixSegue", "AssocSwatchDetailSegue", "unwindToImageViewFromAssoc", "unwindToVC", "SettingsSegue"])
        
        // Test the NavigationController
        //
        var assocNC: UINavigationController = UINavigationController()
        assocNC = storyboard.instantiateViewController(withIdentifier: "NavAssocTableViewController") as! UINavigationController
        XCTAssertTrue(assocNC.topViewController is AssocTableViewController, "AssocTableViewController is embedded in UINavigationController")
    }
    
    // SwatchDetailTableViewController
    //
    func testSwatchDetailTableViewController() {
        var detailTVC: SwatchDetailTableViewController = SwatchDetailTableViewController()
        detailTVC = storyboard.instantiateViewController(withIdentifier: "SwatchDetailTableViewController") as! SwatchDetailTableViewController
        
        tableView  = detailTVC.tableView
        backButton = detailTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertNotNil(tableView)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertNotNil(detailTVC.navigationItem.title!)
        XCTAssertNotNil(detailTVC.title!)
        XCTAssertNil(detailTVC.toolbarItems)
        
        // Check enabled
        //
        XCTAssertTrue(backButton.isEnabled)
        
        // Test for segues
        //
        runSeguesTests(viewController:detailTVC, seguesList:["DetailToAssocSegue", "DetailToRefSegue"])
        
        // Test the NavigationController
        //
        var detailNC: UINavigationController = UINavigationController()
        detailNC = storyboard.instantiateViewController(withIdentifier: "NavSwatchDetailTableViewController") as! UINavigationController
        XCTAssertTrue(detailNC.topViewController is SwatchDetailTableViewController, "SwatchDetailTableViewController is embedded in UINavigationController")
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
        runSeguesTests(viewController:addMixTVC, seguesList:["unwindToAssocFromAdd1", "unwindToAssocFromAdd2", "unwindToAssocFromAdd3"])
        
        // Test the NavigationController
        //
        var addMixNC: UINavigationController = UINavigationController()
        addMixNC = storyboard.instantiateViewController(withIdentifier: "NavAddMixTableViewController") as! UINavigationController
        XCTAssertTrue(addMixNC.topViewController is AddMixTableViewController, "AddMixTableViewController is embedded in UINavigationController")
    }
    
    // Backup NSDefaults
    //
    func backupUserDefaults() {
        pollUpdate = userDefaults.bool(forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Restore NSDefaults
    //
    func restoreUserDefaults() {
        userDefaults.setValue(pollUpdate, forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Test for segues
    //
    func runSeguesTests(viewController: UIViewController, seguesList:[String]) {
        let identifiers = getSeguesIdentifiers(viewController:viewController)
        XCTAssertEqual(identifiers.count, seguesList.count, "Segue count")
        for segue in seguesList {
            XCTAssertTrue(identifiers.contains(segue), "Segue identifier should exist.")
        }
    }
    
    
    // Segues check
    //
    func getSeguesIdentifiers(viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
    func segueTest(identifiers:[String]) {
        XCTAssertTrue(identifiers.contains("InitViewControllerSegue"), "Segue identifier should exist.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
