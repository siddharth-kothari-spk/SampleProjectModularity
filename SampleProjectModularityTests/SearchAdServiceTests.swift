//
//  SearchAdServiceTests.swift
//  SampleProjectModularityTests
//
//  Created by sidkotha on 08/04/23.
//

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
    
    func test_load_withMultipleFilter() {
        let ad1 = makeAd(name: "name1", price: "price1", seller: "seller1")
        let ad2 = makeAd(name: "name2", price: "price2", seller: "seller2")
        let testSM = makeTestSM(ads: [ad1, ad2])
        var receivedAds = [SearchAdModel]()
        testSM.load(filters: ["na","me","2"]) { ads in
            receivedAds += ads
        }

        XCTAssertEqual(receivedAds, [ad2])
    }
    private func makeTestSM(ads: [SearchAdModel] = []) -> SearchAdService {
        let searchModelService = SearchAdService { $0(ads)}
        return searchModelService
    }
}
