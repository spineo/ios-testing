//
//  RGButterflyTests.swift
//  RGButterflyTests
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest


class RGButterflyTests: XCTestCase {
  
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
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
    }
    
    // Main ViewController Unit Tests
    //
    func testViewController() {
        var mainVC: ViewController = ViewController()
        mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        // The navigation items and toolbar item title and buttons
        //
        var imageLibButton: UIBarButtonItem = UIBarButtonItem()
        imageLibButton = mainVC.navigationItem.leftBarButtonItem!
        XCTAssertTrue(imageLibButton.tag == Int(IMAGELIB_BTN_TAG))
        
        // Starts Nil
        //
        XCTAssertNil(mainVC.navigationItem.rightBarButtonItem)
        
        var title: String = String()
        title = mainVC.navigationItem.title!
        XCTAssertNotNil(title)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
