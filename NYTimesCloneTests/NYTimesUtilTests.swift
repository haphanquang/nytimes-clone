//
//  NYTimesUtilTests.swift
//  NYTimesCloneTests
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import XCTest

@testable import NYTimesClone

class NYTimesUtilsTest : XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlusDictionaryFunction(){
        XCTAssert(true == false, "Plus dicitonary wrong")
    }
    
    func testISODateConverter(){
        XCTAssert(Date() == Date(), "ISO date is incorrect")
    }
    
    func testTimeAgo() {
        XCTAssert(false, "Time ago is wrong")
    }
}
