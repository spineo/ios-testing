//
//  RGButterflyTests.swift
//  RGButterflyTests
//
//  Created by Stuart Pineo on 2/9/17.
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
import XCTest


// Pre-Conditions
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Network Connectivity
// REST API return HTTP code 200
//
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
    var titleView     : UIView          = UIView()
    var searchBar     : UISearchBar     = UISearchBar()
    var cancelButton  : UIButton        = UIButton()
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

    var entityCount   : Int             = Int()
    var fileCount     : Int             = Int()
    var dict_id       : Int             = Int()
    var type_id       : Int             = Int()
    
    // UserDefaults
    //
    var userDefaults  : UserDefaults    = UserDefaults()
    var pollUpdate    : Bool            = Bool()
    
    // CoreDataUtils
    //
    var coreDataObj   : CoreDataUtils     = CoreDataUtils()
    var objects       = [AnyObject]()
    var objSet        : NSSet             = NSSet()
    var objArray      = [AnyObject]()
    var objName       : String            = String()
    var swatchType    : PaintSwatchType   = PaintSwatchType()
    var mixAssoc      : MixAssociation    = MixAssociation()
    var paintSwatch   : PaintSwatches     = PaintSwatches()
    var assocSwatches = [MixAssocSwatch]()
    var tapAreas      = [TapArea]()
 
    override func setUp() {
        super.setUp()

        userDefaults      = UserDefaults.standard
        backupUserDefaults()
        
        // Initialize CoreDataUtils
        //
        coreDataObj = CoreDataUtils.init()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        restoreUserDefaults()
    }
    
    // Test the Datamodel Entity Counts
    //
    func testEntityCounts() {
        let dictionaryEntities = ["AssociationType", "BodyType", "CanvasCoverage", "MatchAlgorithm",
                                  "PaintBrand", "PaintSwatchType", "PigmentType", "SubjectiveColor"]
        
        // Test the dictionaries
        //
        for entity in dictionaryEntities {
            fileCount   = Int(FileUtils.fileLineCount(entity, fileType:"txt"))
            entityCount = Int(coreDataObj.fetchCount(entity))
            
            XCTAssertGreaterThan(entityCount, 0, "'\(entity)' count is \(entityCount)!")
            XCTAssertEqual(fileCount, entityCount, "File and Entity count for \(entity) match.")
        }
        
        // Test the main entities count
        //
        let mainEntities = ["Keyword", "MatchAssociation", "MixAssociation", "MixAssocSwatch",
                            "PaintSwatch", "SwatchKeyword", "TapArea", "TapAreaSwatch"]
        for entity in mainEntities {
            entityCount = Int(coreDataObj.fetchCount(entity))
            XCTAssertGreaterThan(entityCount, 0, "'\(entity)!' count is \(entityCount)")
        }
        
        // Greater than or equal to zero
        //
        let otherKeywordEntities = ["MixAssocKeyword", "MatchAssocKeyword", "TapAreaKeyword"]
        for entity in otherKeywordEntities {
            entityCount = Int(coreDataObj.fetchCount(entity))
            XCTAssertGreaterThanOrEqual(entityCount, 0, "'\(entity)' count is \(entityCount)!")
        }
        
        
        // Verify PaintSwatches(MatchAssoc) and TapAreas aggregate counts match
        //
        let typeObj = coreDataObj.queryDictionary("PaintSwatchType", nameValue:"MatchAssoc") as! PaintSwatchType!
        type_id = typeObj?.order as Int!
        let paintSwatchesCount = coreDataObj.fetchedEntityHasId("PaintSwatch", attrName:"type_id", value:Int32(type_id)).count
        
        // TapAreas Count
        //
        let tapAreasCount      = Int(coreDataObj.fetchCount("TapArea"))
        
        XCTAssertGreaterThan(paintSwatchesCount, 0, "PaintSwatches count is zero.")
        XCTAssertEqual(paintSwatchesCount, tapAreasCount, "Aggregate Paint Swatches (MatchAssoc) count of \(paintSwatchesCount) does not match Tap Areas aggregate count of \(tapAreasCount).")
    }
    
    // Test Datamodel Entity relations
    //
    func testEntityRelations() {

        // MixAssociation must have children
        //
        objects = coreDataObj.fetchEntity("MixAssociation")! as! [MixAssociation]
        for assoc in objects {
            objSet  = assoc.mix_assoc_swatch as NSSet
            objName = assoc.name as String
            XCTAssertGreaterThan(objSet.count, 0, "MixAssociation '\(objName)' has no children.")
        }
        
        // All MixAssocSwatches must be part of a MixAssociation
        //
        assocSwatches = coreDataObj.fetchEntity("MixAssocSwatch") as! [MixAssocSwatch]
        for assoc in assocSwatches {
            XCTAssertNotNil(assoc.mix_association, "Found MixAssocSwatch that is not part of a MixAssociation.")
        }
        
        // MatchAssociation must have children
        //
        objects = coreDataObj.fetchEntity("MatchAssociation")! as! [MatchAssociations]
        for assoc in objects {
            objName = assoc.name as String
            XCTAssertGreaterThan(objSet.count, 0, "MatchAssociation '\(objName)' has no children.")
        }
        
        // All TapAreas must be part of a MatchAssociation
        //
        tapAreas = coreDataObj.fetchEntity("TapArea")! as! [TapArea]
        for assoc in tapAreas {
            XCTAssertNotNil(assoc.match_association, "Fount TapArea that is not part of a MatchAssociation.")
        }
        
        // Check for PaintSwatch orphans (skipping "MatchAssoc")
        //
        for type in ["Unknown", "Reference", "MixAssoc", "Ref & Mix", "Generic"] {
            verifyMixSwatchTypes(type:type)
        }

        // Check for Keyword orphans
        //
        objects = coreDataObj.fetchEntity("Keyword") as [AnyObject]
        var swatchKw = Set<SwatchKeyword>()
        for kw in objects {
            if kw.swatch_keyword != nil {
                swatchKw = kw.swatch_keyword!! as Set<SwatchKeyword>
                objName  = kw.name! as String
                XCTAssertGreaterThan(swatchKw.count, 0, "Keyword '\(objName)' has no parent association.")
            }
        }
    }
    
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Supporting methods
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //
    func verifyMixSwatchTypes(type:String) {
        // PaintSwatch must be attached to a Mix Association
        //
        let typeObj = coreDataObj.queryDictionary("PaintSwatchType", nameValue:type) as! PaintSwatchType!
        if typeObj != nil {
            type_id = typeObj?.order as Int!
            objects = coreDataObj.fetchedEntityHasId("PaintSwatch", attrName:"type_id", value:Int32(type_id))! as! [PaintSwatches]
            for swatch in objects {
                objSet  = swatch.mix_assoc_swatch as NSSet
                objName = swatch.name as String
                XCTAssertGreaterThan(objSet.count, 0, "PaintSwatch '\(objName)' has no parent for type '\(type)!'.")
            }
        }
    }
    
    // Backup UserDefaults
    //
    func backupUserDefaults() {
        pollUpdate = userDefaults.bool(forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Restore UserDefaults
    //
    func restoreUserDefaults() {
        userDefaults.setValue(pollUpdate, forKey:DB_POLL_UPDATE_KEY)
    }
    
    // Test for segues
    //
    func runSeguesTests(viewController:UIViewController, seguesList:[String]) {
        let identifiers = getSeguesIdentifiers(viewController:viewController)
        XCTAssertEqual(identifiers.count, seguesList.count, "Segue count")
        for segue in seguesList {
            XCTAssertTrue(identifiers.contains(segue), "Segue identifier should exist.")
        }
    }
    
    // Segues check
    //
    func getSeguesIdentifiers(viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as?
            [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
    // Verify that selector actions can be invoked
    //
    func verifyDirectActions(viewController:UIViewController, actionList:[String]) {
        for action in actionList {
            XCTAssertTrue(viewController.canPerformAction(Selector((action)), withSender:self), "Action '\(action)' failed.")
        }
    }
    
    // Verify that collection views are associated with specific tableView cells (i.e., Match/Mix)
    // and each collection view contains more than zero items
    //
    func verifyCollectionView(viewController:MainViewController, tableView:UITableView, listingType:String) {
        viewController.listingType = listingType
        viewController.loadData()

        let maxIndex = viewController.tableView(tableView, numberOfRowsInSection:0) - 1
        for row in 0...maxIndex {
            let refIndexPath = NSIndexPath(row:row, section:0)
            let cell = viewController.tableView(tableView, cellForRowAt:refIndexPath as IndexPath)
            let subviews = (cell.contentView).subviews
            for view in subviews {
                if view is UICollectionView {
                    let collectionView = view as! UICollectionView
                    XCTAssertGreaterThan(collectionView.numberOfSections, 0)
                    XCTAssertGreaterThan(collectionView.numberOfItems(inSection:0), 0)
                }
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
