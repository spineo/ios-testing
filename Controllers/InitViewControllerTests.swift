//
//  InitViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/11/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest

class InitViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "InitViewController"
    var controller: InitViewController = InitViewController()
    var spinner   : UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        
        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! InitViewController

        // Instantiate
        //
        controller.viewDidLoad()
        controller.viewDidAppear(true)
        
        userDefaults      = UserDefaults.standard
        backupUserDefaults()
        
        // Initialize
        //
        userDefaults.setValue(true, forKey:DB_POLL_UPDATE_KEY)
    }
    
    override func tearDown() {
        super.tearDown()
        
        restoreUserDefaults()
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
    
    // Main View Title
    //
    func testMainViewTitle() {
        XCTAssertNotNil(controller.title!)
    }
    
    // Test for segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["InitViewControllerSegue"])
    }
    
    
    // Test activity indicator animating
    //
    func testActivityIndicatorAnimating() {
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
        controller.viewWillDisappear(true)
        XCTAssertFalse((spinner.isAnimating), "Spinner inactive")
    }
    
    // InitViewController Unit Tests (without pollUpdate, all dynamic checks are skipped)
    // Static checks were performed in the preceding testInitViewController_pollUpdate
    //
    func testNoPollUpdate() {
        let controller = storyboard.instantiateInitialViewController() as! InitViewController
        userDefaults.setValue(false, forKey:DB_POLL_UPDATE_KEY)
        controller.viewDidLoad()
    }
}
