//
//  iOSExerciseTests.swift
//  iOSExerciseTests
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import XCTest
@testable import iOSExercise

class iOSExerciseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateIsMoreThanAnHour() {
        let calendar = Calendar.current
        let now = Date()
        var date = calendar.date(byAdding: .minute, value: 30, to: Date())!
        
        XCTAssertFalse(date.isMoreThanAnHour(date: now))
        
        date = calendar.date(byAdding: .minute, value: 61, to: Date())!
        
        XCTAssertTrue(date.isMoreThanAnHour(date: now))
        
        date = calendar.date(byAdding: .day, value: -5, to: Date())!
        
        XCTAssertFalse(date.isMoreThanAnHour(date: now))
        
        date = calendar.date(byAdding: .day, value: 1, to: Date())!
        
        XCTAssertTrue(date.isMoreThanAnHour(date: now))
    }
    
    func testDateIsMoreThan20Seconds() {
        let calendar = Calendar.current
        let now = Date()
        var date = calendar.date(byAdding: .second, value: 10, to: Date())!
        
        XCTAssertFalse(date.isMoreThan20Seconds(date: now))
        
        date = calendar.date(byAdding: .second, value: 21, to: Date())!
        
        XCTAssertTrue(date.isMoreThan20Seconds(date: now))
    }

}
