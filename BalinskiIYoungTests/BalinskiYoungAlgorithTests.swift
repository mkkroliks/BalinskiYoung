//
//  BalinskiYoungAlgorithTests.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 05/04/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import XCTest

class BalinskiYoungAlgorithTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testIsResultValid() {
        
        let parliamentCount: Double = 5
        let populations: [Double] = [7270, 1230, 2220]
        
        let a = BalinskiYoungAlgorith.count(populations, parliamentCount: parliamentCount)
        
        XCTAssertEqual(a, [4,0,1])
    }
    
    func testResultForSingleState() {
        let parliamentCount: Double = 5
        let populations: [Double] = [7270]
        
        let a = BalinskiYoungAlgorith.count(populations, parliamentCount: parliamentCount)
        
        XCTAssertEqual(a, [5])
    }

}