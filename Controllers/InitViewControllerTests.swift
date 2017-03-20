//
//  InitViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/11/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest

class InitViewControllerTests: RGButterflyBaseTests {
    
    override func setUp() {
        super.setUp()
        
        userDefaults      = UserDefaults.standard
        backupUserDefaults()
    }
    
    override func tearDown() {
        super.tearDown()
        
        restoreUserDefaults()
    }
    
    // InitViewController Unit Tests
    // Two paths checked: pollUpdate and noPollUpdate (actual database update skipped for now)
    //
    func testInitViewController_pollUpdate() {
        // Check the requirements
        //
        if (!HTTPUtils.networkIsReachable()) {
            XCTFail("No network connectivty")
        }
        
        if (!HTTPUtils.urlIsReachable(DB_ROOT_URL)) {
            XCTFail("No REST API connectivty")
        }
        
        var initVC: InitViewController = InitViewController()
        initVC = storyboard.instantiateInitialViewController() as! InitViewController
        
        userDefaults.setValue(true, forKey:DB_POLL_UPDATE_KEY)
        
        // Instantiate
        //
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
    func testInitViewController_noPollUpdate() {
        var initVC: InitViewController = InitViewController()
        initVC = storyboard.instantiateInitialViewController() as! InitViewController
        
        userDefaults.setValue(false, forKey:DB_POLL_UPDATE_KEY)
        
        initVC.viewDidLoad()
    }
}
