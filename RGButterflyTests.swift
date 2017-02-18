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
// Controller/NavController titles are not null
// Buttons have the correct tags
//
class RGButterflyTests: XCTestCase {
  
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    var topLeftButton: UIBarButtonItem = UIBarButtonItem()
    
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
        
        var view: UIView = UIView()
        view = initVC.view
        
        XCTAssertNotNil(view)
        XCTAssertNotNil(initVC.title!)
    }
    
    // Main ViewController Unit Tests
    //
    func testViewController() {
        var mainVC: ViewController = ViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        // The navigation items and toolbar item title and buttons
        //
        topLeftButton = mainVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(IMAGELIB_BTN_TAG))
        XCTAssertNil(mainVC.navigationItem.rightBarButtonItem)
        XCTAssertNotNil(mainVC.navigationItem.title!)
    }
    
    // SettingsTableViewController
    //
    func testSettingsViewController() {
        var settingsTVC: SettingsTableViewController = SettingsTableViewController()
        settingsTVC = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        
        topLeftButton = settingsTVC.navigationItem.leftBarButtonItem!

        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(settingsTVC.navigationItem.title!)
    }
    
    // AboutViewController
    //
    func testAboutViewController() {
        var aboutVC: AboutViewController = AboutViewController()
        aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController

        topLeftButton = aboutVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(aboutVC.navigationItem.title!)
    }
    
    // AboutViewController
    //
    func testDisclaimerViewController() {
        var disclaimerVC: DisclaimerViewController = DisclaimerViewController()
        disclaimerVC = storyboard.instantiateViewController(withIdentifier: "DisclaimerViewController") as! DisclaimerViewController
        
        topLeftButton = disclaimerVC.navigationItem.leftBarButtonItem!

        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(disclaimerVC.navigationItem.title!)
    }
    
    // PickerViewController
    //
    func testPickerViewController() {
        var pickerVC: PickerViewController = PickerViewController()
        pickerVC = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController

        XCTAssertNotNil(pickerVC.title!)
    }
    
    // UIImageViewController
    //
    func testUIImageViewController() {
        var imageVC: UIImageViewController = UIImageViewController()
        imageVC = storyboard.instantiateViewController(withIdentifier: "UIImageViewController") as! UIImageViewController
        
        topLeftButton = imageVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(imageVC.navigationItem.title!)
    }
    
    // MatchTableViewController
    //
    func testMatchTableViewController() {
        var matchTVC: MatchTableViewController = MatchTableViewController()
        matchTVC = storyboard.instantiateViewController(withIdentifier: "MatchTableViewController") as! MatchTableViewController
        
        topLeftButton = matchTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(matchTVC.navigationItem.title!)
    }
    
    // AssocTableViewController
    //
    func testAssocTableViewController() {
        var assocTVC: AssocTableViewController = AssocTableViewController()
        assocTVC = storyboard.instantiateViewController(withIdentifier: "AssocTableViewController") as! AssocTableViewController
        
        topLeftButton = assocTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(assocTVC.navigationItem.title!)
    }
    
    // SwatchDetailTableViewController
    //
    func testSwatchDetailTableViewController() {
        var detailTVC: SwatchDetailTableViewController = SwatchDetailTableViewController()
        detailTVC = storyboard.instantiateViewController(withIdentifier: "SwatchDetailTableViewController") as! SwatchDetailTableViewController
        
        topLeftButton = detailTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(detailTVC.navigationItem.title!)
    }
    
    // AddMixTableViewController
    //
    func testAddMixTableViewController() {
        var addMixTVC: AddMixTableViewController = AddMixTableViewController()
        addMixTVC = storyboard.instantiateViewController(withIdentifier: "AddMixTableViewController") as! AddMixTableViewController
        
        topLeftButton = addMixTVC.navigationItem.leftBarButtonItem!
        
        XCTAssertTrue(topLeftButton.tag == Int(BACK_BTN_TAG))
        XCTAssertNotNil(addMixTVC.navigationItem.title!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
