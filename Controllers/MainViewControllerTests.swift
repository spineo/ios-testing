//
//  MainViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class MainViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "MainViewController"
    var controller: MainViewController = MainViewController()
    var spinner   : UIActivityIndicatorView = UIActivityIndicatorView()
    
    let listingTypes = [MIX_LIST_TYPE, MATCH_LIST_TYPE, FULL_LISTING_TYPE, KEYWORDS_TYPE, COLORS_TYPE];
    
    override func setUp() {
        super.setUp()
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! MainViewController
        
        // Instantiate
        //
        controller.viewDidLoad()
        controller.viewWillAppear(true)
        controller.viewDidAppear(true)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Controller exists
    //
    func testControllerExists() {
        XCTAssertNotNil(controller, "'\(controllerName)' is nil")
    }
    
    // Main View
    //
    func testMainView() {
        XCTAssertNotNil(controller.view)
    }
    
    // Controller title
    //
    func testControllerTitle() {
        XCTAssertNotNil(controller.title!)
    }
    
    // NavigationItem Title
    //
    func testNavTitle() {
        XCTAssertNotNil(controller.navigationItem.title!)
    }
    
    // Test activity indicator animating
    //
    func testActivityIndicatorAnimating() {
        // Re-instantiate
        //
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! MainViewController
        controller.viewDidLoad()
        controller.viewWillAppear(true)
        
        // Check the update label and spinner initial states
        //
        let updateLabel = controller.view.viewWithTag(Int(INIT_LABEL_TAG)) as? UILabel
        XCTAssertEqual(updateLabel?.text, SPINNER_LABEL_LOAD, "Initial spinner label")
        
        spinner     = (controller.view.viewWithTag(Int(INIT_SPINNER_TAG)) as? UIActivityIndicatorView)!
        XCTAssert((spinner.isAnimating), "Spinner active")
    }
    
    // Test activity indicator not animating (final state)
    //
    func testActivityIndicatorNotAnimating() {
        controller.viewDidDisappear(true)
        XCTAssertFalse((spinner.isAnimating), "Spinner inactive")
    }
    
    // Test that dictionaries have loaded
    //
    func testDictionariesCounts() {
        XCTAssertGreaterThan(controller.subjColorNames.count, 0, "No dictionary colors loaded")
        XCTAssertEqual(controller.portraitKeywordsIndex.count, 26, "Portrait: Not all alphabet letters showing")
        XCTAssertEqual(controller.landscapeKeywordsIndex.count, 18, "Landscape: Not all alphabet letters subset showing")
        XCTAssertEqual(controller.smallKeywordsIndex.count, 16, "Small Screen: Not all alphabet letters subset showing")
    }
    
    // Test the loaded PaintSwatches
    //
    func testLoadedPaintSwatches() {
        XCTAssertGreaterThan(controller.paintSwatches.count, 0, "Paint Swatches count is zero")
    }
    
    // TableView exists
    //
    func testTableView() {
        let tableView    = controller.view.subviews.first as! UITableView
        XCTAssertNotNil(tableView, "'\(controllerName)' tableview is nil")
    }
    
    // TitleView exists
    //
    func testTitleView() {
        let titleView       = controller.titleView
        XCTAssertNotNil(titleView, "'\(controllerName)' titleview is nil")
        
    }
    
    // ImageLib Button
    //
    func testImageLibButton() {
        let imageLibButton = controller.navigationItem.leftBarButtonItem!
        XCTAssertEqual(imageLibButton.tag, Int(IMAGELIB_BTN_TAG))
        XCTAssertTrue(imageLibButton.isEnabled)
    }
    
    // ImageLib Button
    //
    func testSearchButton() {
        let searchButton = controller.navigationItem.rightBarButtonItem!
        XCTAssertEqual(searchButton.tag,   Int(SEARCH_BTN_TAG))
        XCTAssertTrue(searchButton.isEnabled)
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
        
        let listingButton      = toolbarItems.removeFirst()
        XCTAssertEqual(listingButton.tag,    Int(LISTING_BTN_TAG))
        XCTAssertTrue(listingButton.isEnabled)
        
        let flexibleSpace2  = toolbarItems.removeFirst()
        XCTAssertEqual(flexibleSpace2.tag, Int(FLEXIBLE_SPACE_TAG))
        
        let settingsButton = toolbarItems.removeFirst()
        XCTAssertEqual(settingsButton.tag, Int(SETTINGS_BTN_TAG))
        XCTAssertTrue(settingsButton.isEnabled)
    }
    
    // Test the Search Bar field
    //
    func testSearchBar() {
        let searchBar = controller.titleView.viewWithTag(Int(SEARCH_BAR_TAG)) as! UISearchBar
        XCTAssertNotNil(searchBar)
    }
    
    // Test the Cancel Button
    //
    func testCancelButton() {
        let cancelButton = controller.titleView.viewWithTag(Int(CANCEL_BUTTON_TAG)) as! UIButton
        XCTAssertNotNil(cancelButton)
    }
    
    // Test the Segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["MainSwatchDetailSegue", "VCToAssocSegue", "ImagePickerSegue",
                                                              "ImageSelectionSegue", "SettingsSegue"])
    }
    
    // Verify tableView section counts
    //
    func testTableViewSectionCounts() {
        for type in self.listingTypes {
            verifycontrollerSectionsCounts(viewController:controller, tableView:controller.colorTableView!, listingType:type)
        }
    }
    
    // Verify Match collection view counts
    //
    func testMatchCollectionViewCounts() {
        verifyCollectionView(viewController:controller, tableView:controller.colorTableView!, listingType:MATCH_LIST_TYPE)
    }
    
    // Verify Mix collection view counts
    //
    func testMixCollectionViewCounts() {
        verifyCollectionView(viewController:controller, tableView:controller.colorTableView!, listingType:MIX_LIST_TYPE)
    }
    
    // Test the NavigationController
    //
    func testNavController() {
        let navController = storyboard.instantiateViewController(withIdentifier: "NavViewController") as! UINavigationController
        XCTAssertTrue(navController.topViewController is MainViewController, "'\(controller)' is embedded in UINavigationController")
    }
    
    // Test direct actions
    //
    func testDirectActions() {
        // NavBar
        //
        verifyDirectActions(viewController:controller, actionList:["showPhotoOptions:", "search"])
        
        // Tableview
        //
        verifyDirectActions(viewController:controller, actionList:["showAllColors", "filterByReference", "filterByGenerics", "searchBarSetFrames", "pressCancel", "expandAllSections", "expandOrCollapseSection:", "collapseAllSections", "mergeChanges:"])
        
        // Toolbar ('Home' button is inactive and 'Settings' button triggers a segue)
        //
        verifyDirectActions(viewController:controller, actionList:["showListingOptions:"])
    }

    // Test the IBOutlets
    //
    func testIBOutlets() {
        XCTAssertNotNil(controller.colorTableView, "IBOutlet 'colorTableView' is nil")
    }
    
    // Test the Delegates
    //
    func testDelegates() {
        XCTAssertTrue(controller.colorTableView.delegate is UITableViewDataSource)
        XCTAssertTrue(controller.colorTableView.delegate is UICollectionViewDataSource)
        XCTAssertTrue(controller.colorTableView.delegate is UICollectionViewDelegate)
        XCTAssertTrue(controller.colorTableView.delegate is NSFetchedResultsControllerDelegate)
        XCTAssertTrue(controller.colorTableView.delegate is UISearchBarDelegate)
    }

    // Measure times to display each listing
    //
    func testListingDisplay() {
        controller.viewDidLoad()
        controller.viewWillAppear(true)

        self.measure {
            for type in self.listingTypes {
                print("*** Measuring Listing Type '\(type)' for Performance ***")
                self.controller.listingType = type
                self.controller.loadData()
            }
        }
    }
    
    // Supporting methods
    //
    func verifycontrollerSectionsCounts(viewController:MainViewController, tableView:UITableView, listingType:String) {
        viewController.listingType = listingType
        viewController.loadData()
        let entityCount = Int(viewController.sectionsCount)
        XCTAssertGreaterThan(Int(entityCount), 0)
        XCTAssertEqual(viewController.numberOfSections(in:tableView), entityCount)
    }
}
