//
//  PickerViewControllerTests.swift
//  RGButterfly
//
//  Created by Stuart Pineo on 3/12/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

import XCTest

class PickerViewControllerTests: RGButterflyBaseTests {
    
    let controllerName = "PickerViewController"
    var controller: PickerViewController = PickerViewController()
    
    override func setUp() {
        super.setUp()

        controller = storyboard.instantiateViewController(withIdentifier: controllerName) as! PickerViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Controller exists
    //
    func testControllerExists() {
        XCTAssertNotNil(controller, "'\(controllerName)' is nil")
    }
    
    // NavigationItem Back Button
    //
    func testBackButton() {
        let backButton = controller.navigationItem.leftBarButtonItem!
        XCTAssertNotNil(backButton)
        XCTAssertEqual(backButton.tag, Int(BACK_BTN_TAG))
        XCTAssertTrue(backButton.isEnabled)
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
    
    // Confirm no segues
    //
    func testSegues() {
        runSeguesTests(viewController:controller, seguesList:["ImageViewSegue"])
    }
    
    // Selector action
    //
    func testDirectActions() {
        XCTAssertTrue(controller.canPerformAction(Selector(("dismissPicker:")), withSender:self))
    }
}
