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
    }
    
    private func makeTestVC(filter: String?) -> AdViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let testVC = sb.instantiateViewController(identifier: "AdViewController") {coder in
            return AdViewController(coder: coder, filteredText: filter)
        }
        return testVC
    }

}
