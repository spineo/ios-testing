//
//  MainViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class MainViewControllerTests: RGButterflyTests {
    
    var mainVC: MainViewController = MainViewController()
    var listingTypes = [String]()
    
    override func setUp() {
        super.setUp()
        
        listingTypes = [MIX_TYPE, MATCH_TYPE, FULL_LISTING_TYPE, KEYWORDS_TYPE, COLORS_TYPE];
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MainViewController Unit Tests
    //
    func testMainViewController() {
        self.mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        view   = self.mainVC.view
        
        // Instantiate
        //
        self.mainVC.viewDidLoad()
        self.mainVC.viewWillAppear(true)
        
        // Check the update label and spinner initial states
        //
        let updateLabel = view.viewWithTag(Int(INIT_LABEL_TAG)) as? UILabel
        XCTAssertEqual(updateLabel?.text, SPINNER_LABEL_LOAD, "Initial spinner label")
        
        let spinner     = view.viewWithTag(Int(INIT_SPINNER_TAG)) as? UIActivityIndicatorView
        XCTAssert((spinner?.isAnimating)!, "Spinner active")
        
        self.mainVC.viewDidAppear(true)
        self.mainVC.viewDidDisappear(true)
        
        // Final state
        //
        XCTAssertFalse((spinner?.isAnimating)!, "Spinner inactive")
        
        // Counts
        //
        XCTAssertGreaterThan(mainVC.subjColorNames.count, 0, "No dictionary colors loaded")
        XCTAssertEqual(mainVC.keywordsIndexTitles.count, 26, "Not all alphabet letters showing")
        
        
        // The views, navigation items and toolbar item title and buttons
        //
        tableView      = view.subviews.first as! UITableView
        imageLibButton = self.mainVC.navigationItem.leftBarButtonItem!
        searchButton   = self.mainVC.navigationItem.rightBarButtonItem!
        
        toolbarItems    = self.mainVC.toolbarItems!
        homeButton      = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace   = toolbarItems.removeFirst() as! UIBarButtonItem
        listingButton   = toolbarItems.removeFirst() as! UIBarButtonItem
        flexibleSpace2  = toolbarItems.removeFirst() as! UIBarButtonItem
        settingsButton  = toolbarItems.removeFirst() as! UIBarButtonItem
        
        // Title View
        //
        titleView       = self.mainVC.titleView
        
        // Views
        //
        XCTAssertNotNil(view)
        XCTAssertNotNil(tableView)
        XCTAssertNotNil(titleView)
        
        // Search bar
        //
        searchBar = titleView.viewWithTag(Int(SEARCH_BAR_TAG)) as! UISearchBar
        XCTAssertNotNil(searchBar)
        cancelButton = titleView.viewWithTag(Int(CANCEL_BUTTON_TAG)) as! UIButton
        XCTAssertNotNil(cancelButton)
        
        
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
        runSeguesTests(viewController:mainVC, seguesList:["MainSwatchDetailSegue", "VCToAssocSegue", "ImagePickerSegue",
                                                          "ImageSelectionSegue", "SettingsSegue"])
        
        // Count loaded objects
        //
        XCTAssertGreaterThan(mainVC.paintSwatches.count, 0, "Paint Swatches count is zero")
        
        
        // Instantiate and test tableView sections/rows count
        //
        let mainTableView = self.mainVC.colorTableView

        for type in self.listingTypes {
            verifyMainVCSectionsCounts(viewController:mainVC, tableView:mainTableView!, listingType:type)
            
            // Verify the collection views
            //
            if (type == MIX_TYPE || type == MATCH_TYPE) {
                verifyCollectionView(viewController:mainVC, tableView:mainTableView!, listingType:type)
            }
        }
        
        // Test the NavigationController
        //
        var mainNC: UINavigationController = UINavigationController()
        mainNC = storyboard.instantiateViewController(withIdentifier: "NavViewController") as! UINavigationController
        XCTAssertTrue(mainNC.topViewController is MainViewController, "MainViewController is embedded in UINavigationController")
        
        // Test actions
        //
        // NavBar
        //
        verifyDirectActions(viewController:mainVC, actionList:["showPhotoOptions:", "search"])
        
        // Tableview
        //
        verifyDirectActions(viewController:mainVC, actionList:["showAllColors", "filterByReference", "filterByGenerics", "searchBarSetFrames", "pressCancel", "expandAllSections", "expandOrCollapseSection:", "collapseAllSections", "mergeChanges:"])
        
        // Toolbar ('Home' button is inactive and 'Settings' button triggers a segue)
        //
        verifyDirectActions(viewController:mainVC, actionList:["showListingOptions:"])
        
        // Test the delegates
        //
        
        // Test the IBOutlet
        //
        XCTAssertNotNil(mainVC.colorTableView, "IBOutlet 'colorTableView' is nil")
    }

    // Measure times to display each listing
    //
    func testListingDisplay() {
        self.mainVC.viewDidLoad()
        self.mainVC.viewWillAppear(true)

        self.measure {
            for type in self.listingTypes {
                print("Measuring Listing Type '\(type)' for Performance.")
                self.mainVC.listingType = type
                self.mainVC.loadData()
            }
        }
    }
    
    // Supporting methods
    //
    func verifyMainVCSectionsCounts(viewController:MainViewController, tableView:UITableView, listingType:String) {
        viewController.listingType = listingType
        viewController.loadData()
        entityCount = Int(viewController.sectionsCount)
        XCTAssertGreaterThan(Int(entityCount), 0)
        XCTAssertEqual(viewController.numberOfSections(in:tableView), entityCount)
    }
}
