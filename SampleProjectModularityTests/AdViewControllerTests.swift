//
//  AdViewControllerTests.swift
//  SampleProjectModularityTests
//
//  Created by sidkotha on 08/04/23.
//

/*
 Test checklist
 
 - VC init
 - viewDidLoad
    - default/initial UI values
    - any network request
        - on success
        - on failure
 
 
 - filter changed
    - UI update
     - any network request
         - on success
         - on failure
 */
import XCTest
@testable import SampleProjectModularity

class SearchAdServiceTests: XCTestCase {
    
    func test_load_withoutFilter() {
        let ad1 = makeAd(name: "name1", price: "price1", seller: "seller1")
        let ad2 = makeAd(name: "name2", price: "price2", seller: "seller2")
        let testSM = makeTestSM(ads: [ad1, ad2])
        var receivedAds = [SearchAdModel]()
        testSM.load(filters: []) { ads in
            receivedAds += ads // always use addition instead of assigning as if completionHandler is called twice , it will not fail in case of assignment
        }
        
        XCTAssertEqual(receivedAds, [ad1, ad2]) // error : Global function 'XCTAssertEqual(_:_:_:file:line:)' requires that 'SearchAdModel' conform to 'Equatable'
    }
    
    
    func test_load_withFilter() {
        let ad1 = makeAd(name: "name1", price: "price1", seller: "seller1")
        let ad2 = makeAd(name: "name2", price: "price2", seller: "seller2")
        let testSM = makeTestSM(ads: [ad1, ad2])
        var receivedAds = [SearchAdModel]()
        testSM.load(filters: ["name1"]) { ads in
            receivedAds += ads
        }

        XCTAssertEqual(receivedAds, [ad1])
    }
    
    private func makeTestSM(ads: [SearchAdModel] = []) -> SearchAdService {
        let searchModelService = SearchAdService()
        searchModelService.getAds = { $0(ads) }
        return searchModelService
    }
}

final class AdViewControllerTests: XCTestCase {
    
    func test_canInit() {
        _ = makeTestVC(filter: nil)
                
    }
    
    func test_viewDidLoad_withoutFilter_defaultValues() {
        let testVC = makeTestVC(filter: nil)
        testVC.loadViewIfNeeded()
        
        XCTAssertEqual(testVC.tableView.numberOfRows(inSection: 0), 0)
        
        // to be used if setup in code
      /*  XCTAssertEqual(testVC.filterButton.title(for: .normal), "Filter")
          XCTAssertEqual(testVC.carsOnlyButton.title(for: .normal), "Cars Only")
        */
        
        // to be used if setup in storyboard
        XCTAssertEqual(testVC.filterButton.configuration?.title, "Filter")
        XCTAssertEqual(testVC.carsOnlyButton.configuration?.title, "Cars Only")
        
        
        XCTAssertEqual(testVC.carsOnlyButton.tintColor, .red)
        XCTAssertEqual(testVC.numberOfFiltersLabel.text, "0 filters")
    }
    
    
    func test_viewDidLoad_withoutFilter_loadAds_withoutFilter() {
        let ad1 = makeAd(name: "name1", price: "price1", seller: "seller1")
        let ad2 = makeAd(name: "name2", price: "price2", seller: "seller2")
        let testVC = makeTestVC(filter: nil, ads: [ad1, ad2])
        testVC.loadViewIfNeeded()
        
        XCTAssertEqual(testVC.tableView.numberOfRows(inSection: 0), 2)
        let cell1 = testVC.tableView.dataSource?.tableView(testVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AdTableViewCell
        XCTAssertEqual(cell1?.nameText.text, "name1")
        XCTAssertEqual(cell1?.priceText.text, "price1")
        XCTAssertEqual(cell1?.sellerNameText.text, "seller1")
        
        let cell2 = testVC.tableView.dataSource?.tableView(testVC.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? AdTableViewCell
        XCTAssertEqual(cell2?.nameText.text, "name2")
        XCTAssertEqual(cell2?.priceText.text, "price2")
        XCTAssertEqual(cell2?.sellerNameText.text, "seller2")

    }
    
    
    func test_viewDidLoad_withFilter_defaultValues() {
        let testVC = makeTestVC(filter: "a filter")
        testVC.loadViewIfNeeded()
        
        XCTAssertEqual(testVC.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(testVC.filterButton.title(for: .normal), "Filter is a filter")
        XCTAssertEqual(testVC.carsOnlyButton.configuration?.title, "Cars Only")
        XCTAssertEqual(testVC.carsOnlyButton.tintColor, .red)
        XCTAssertEqual(testVC.numberOfFiltersLabel.text, "1 filters")
    }
    
    
    func test_viewDidLoad_withFilter_loadAds_withFilter() {
        let ad1 = makeAd(name: "name1", price: "price1", seller: "seller1")
        let ad2 = makeAd(name: "name2", price: "price2", seller: "seller2")
        let testVC = makeTestVC(filter: "name1", ads: [ad1, ad2])
        testVC.loadViewIfNeeded()
        
        XCTAssertEqual(testVC.filteredText, "name1" )
        XCTAssertEqual(testVC.tableView.numberOfRows(inSection: 0), 1)
        let cell1 = testVC.tableView.dataSource?.tableView(testVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AdTableViewCell
        XCTAssertEqual(cell1?.nameText.text, "name1")
        XCTAssertEqual(cell1?.priceText.text, "price1")
        XCTAssertEqual(cell1?.sellerNameText.text, "seller1")
    }
    
    private func makeTestVC(filter: String?, ads: [SearchAdModel] = []) -> AdViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let testVC = sb.instantiateViewController(identifier: "AdViewController") {coder in
            return AdViewController(coder: coder, filteredText: filter)
        }
        testVC.getAds = { completion in completion(ads) }
        return testVC
    }
}


private func makeAd(name: String, price: String, seller: String) -> SearchAdModel {
    SearchAdModel(ad: AdModel(id: UUID(),
                              name: name,
                              price: Price(priceAmount: 0,
                                           priceString: price),
                              seller: Seller(name: seller,
                                             website: nil),
                              image: nil),
                  searchedQuery: "any search query")
}
