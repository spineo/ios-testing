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
        
        // Test selectors/actions
        //
        XCTAssertTrue(pickerVC.canPerformAction(Selector(("dismissPicker:")), withSender:self))
    }
}
