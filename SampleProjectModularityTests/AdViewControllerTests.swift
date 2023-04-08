//
//  AdViewControllerTests.swift
//  SampleProjectModularityTests
//
//  Created by sidkotha on 08/04/23.
//

import XCTest
@testable import SampleProjectModularity
final class AdViewControllerTests: XCTestCase {
    
    func test_canInit() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let testVC = sb.instantiateViewController(identifier: "AdViewController") {coder in
            return AdViewController(coder: coder, filteredText: nil)
        }
}

}
