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
    
    
    func test_viewDidLoad_withFilter_defaultValues() {
        let testVC = makeTestVC(filter: "a filter")
        testVC.loadViewIfNeeded()
        
        XCTAssertEqual(testVC.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(testVC.filterButton.title(for: .normal), "Filter is a filter")
        XCTAssertEqual(testVC.carsOnlyButton.configuration?.title, "Cars Only")
        XCTAssertEqual(testVC.carsOnlyButton.tintColor, .red)
        XCTAssertEqual(testVC.numberOfFiltersLabel.text, "1 filters")
    }
    
    
    private func makeTestVC(filter: String?) -> AdViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let testVC = sb.instantiateViewController(identifier: "AdViewController") {coder in
            return AdViewController(coder: coder, filteredText: filter)
        }
        testVC.getAds = { _ in }
        return testVC
    }

}
