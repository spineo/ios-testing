//
//  RGButterflyTests.swift
//  DataModelTests - Tests the RGButterfly Data Model Counts and Relations
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest

class DataModelTests: XCTestCase {
  
    var coreDataObj : CoreDataUtils = CoreDataUtils()
 
    override func setUp() {
        super.setUp()

        // Initialize CoreDataUtils
        //
        coreDataObj = CoreDataUtils.init()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Test the Dictionary Entities Counts
    //
    func testDictionaryEntitiesCounts() {
        let dictionaryEntities = ["AssociationType", "BodyType", "CanvasCoverage", "MatchAlgorithm",
                                  "PaintBrand", "PaintSwatchType", "PigmentType", "SubjectiveColor"]
        
        // Test the dictionaries
        //
        for entity in dictionaryEntities {
            let fileCount   = Int(FileUtils.fileLineCount(entity, fileType:"txt"))
            let entityCount = Int(coreDataObj.fetchCount(entity))
            
            XCTAssertGreaterThan(entityCount, 0, "'\(entity)' count is \(entityCount)!")
            XCTAssertEqual(fileCount, entityCount, "File and Entity count for \(entity) match.")
        }
    }
        
    // Test the Main Entities count
    //
    func testMainEntitiesCounts() {
        let mainEntities = ["Keyword", "MatchAssociation", "MixAssociation", "MixAssocSwatch",
                            "PaintSwatch", "SwatchKeyword", "TapArea", "TapAreaSwatch"]
        for entity in mainEntities {
            let entityCount = Int(coreDataObj.fetchCount(entity))
            XCTAssertGreaterThan(entityCount, 0, "'\(entity)' count is \(entityCount)")
        }
    }
    
    // Test the Other Keyword Entities (currently not set)
    //
    func testOtherKeywordsEntitiesCount() {
        // Greater than or equal to zero
        //
        let otherKeywordEntities = ["MixAssocKeyword", "MatchAssocKeyword", "TapAreaKeyword"]
        for entity in otherKeywordEntities {
            let entityCount = Int(coreDataObj.fetchCount(entity))
            XCTAssertGreaterThanOrEqual(entityCount, 0, "'\(entity)' count is \(entityCount)!")
        }
    }
        
        
    // Verify PaintSwatches(MatchAssoc) and TapAreas aggregate counts match
    //
    func testMatchAssociationsAndTapAreasCount() {
        let typeObj = coreDataObj.queryDictionary("PaintSwatchType", nameValue:"MatchAssoc") as! PaintSwatchType!
        let type_id = typeObj?.order as Int!
        let paintSwatchesCount = coreDataObj.fetchedEntityHasId("PaintSwatch", attrName:"type_id", value:Int32(type_id!)).count
        
        // TapAreas Count
        //
        let tapAreasCount      = Int(coreDataObj.fetchCount("TapArea"))
        
        XCTAssertGreaterThan(paintSwatchesCount, 0, "PaintSwatches count is zero.")
        XCTAssertEqual(paintSwatchesCount, tapAreasCount, "Aggregate Paint Swatches (MatchAssoc) count of \(paintSwatchesCount) does not match Tap Areas aggregate count of \(tapAreasCount).")
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Test the Datamodel Entity relations
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // MixAssociation must have children
    //
    func testMixAssociationHasChildren() {
        let objects = coreDataObj.fetchEntity("MixAssociation")! as! [MixAssociation]
        for assoc in objects {
            let objSet  = assoc.mix_assoc_swatch as NSSet
            let objName = assoc.name as String
            XCTAssertGreaterThan(objSet.count, 0, "MixAssociation '\(objName)' has no children.")
        }
    }
    
    // All MixAssocSwatches must be part of a MixAssociation
    //
    func testMixAssocSwatchesAreInMixAssociation() {
        let assocSwatches = coreDataObj.fetchEntity("MixAssocSwatch") as! [MixAssocSwatch]
        for assoc in assocSwatches {
            XCTAssertNotNil(assoc.mix_association, "Found MixAssocSwatch that is not part of a MixAssociation.")
        }
    }
        
    // MatchAssociation must have children
    //
    func testMatchAssociationHasChildren() {
        let objects = coreDataObj.fetchEntity("MatchAssociation")! as! [MatchAssociations]
        for assoc in objects {
            let objSet  = assoc.tap_area as NSSet
            let objName = assoc.name as String
            XCTAssertGreaterThan(objSet.count, 0, "MatchAssociation '\(objName)' has no children.")
        }
    }
        
    // All TapAreas must be part of a MatchAssociation
    //
    func testTapAreasAreInMatchAssociation() {
        let tapAreas = coreDataObj.fetchEntity("TapArea")! as! [TapArea]
        for assoc in tapAreas {
            XCTAssertNotNil(assoc.match_association, "Fount TapArea that is not part of a MatchAssociation.")
        }
    }
    
    // All PaintSwatches must be part of an Association
    //
    func testNoPaintSwatchOrphansExist() {

        // Check for PaintSwatch orphans (skipping "MatchAssoc")
        //
        for type in ["Other", "Reference", "MixAssoc", "Ref & Mix", "Generic"] {
            verifyMixSwatchTypes(type:type)
        }
    }
    
    // Each Keyword must be associated with one or more PaintSwatches
    //
    func testNoKeywordOrphansExist() {

        // Check for Keyword orphans
        //
        let objects = coreDataObj.fetchEntity("Keyword") as [AnyObject]
        for kw in objects {
            if kw.swatch_keyword != nil {
                let swatchKw = kw.swatch_keyword!! as Set<SwatchKeyword>
                let objName  = kw.name! as String
                XCTAssertGreaterThan(swatchKw.count, 0, "Keyword '\(objName)' has no parent association.")
            }
        }
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // DataModelTests Supporting methods
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    private func verifyMixSwatchTypes(type:String) {

        // PaintSwatch must be attached to an Association
        //
        let typeObj = coreDataObj.queryDictionary("PaintSwatchType", nameValue:type) as! PaintSwatchType!
        if typeObj != nil {
            let type_id = typeObj?.order as Int!
            let objects = coreDataObj.fetchedEntityHasId("PaintSwatch", attrName:"type_id", value:Int32(type_id!))! as! [PaintSwatches]
            for swatch in objects {
                let objSet  = swatch.mix_assoc_swatch! as Set<MixAssocSwatch>
                let objName = swatch.name! as String

                XCTAssertGreaterThan(objSet.count, 0, "PaintSwatch '\(objName)' has no parent for type '\(type)'.")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
