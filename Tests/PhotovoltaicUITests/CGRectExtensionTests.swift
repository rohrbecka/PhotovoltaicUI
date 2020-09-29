//
//  CGRectExtensionTests.swift
//  SenecUI_iOSTests
//
//  Created by André Rohrbeck on 12.01.19.
//  Copyright © 2019 André Rohrbeck. All rights reserved.
//

import XCTest
@testable import PhotovoltaicUI

class CGRectExtensionTests: XCTestCase {

    func test_centerLeft () {
        let sut1 = CGRect(x: 10, y: 20, width: 100, height: 200)
        XCTAssertEqual(sut1.centerLeft, CGPoint(x: 10, y: 120))

        let sut2 = CGRect(x: 110, y: 120, width: 10, height: 20)
        XCTAssertEqual(sut2.centerLeft, CGPoint(x: 110, y: 130))
    }



    func test_centerRight () {
        let sut1 = CGRect(x: 10, y: 20, width: 100, height: 200)
        XCTAssertEqual(sut1.centerRight, CGPoint(x: 110, y: 120))

        let sut2 = CGRect(x: 110, y: 120, width: 10, height: 20)
        XCTAssertEqual(sut2.centerRight, CGPoint(x: 120, y: 130))
    }



    func test_centerTop () {
        let sut1 = CGRect(x: 10, y: 20, width: 100, height: 200)
        XCTAssertEqual(sut1.centerTop, CGPoint(x: 60, y: 20))

        let sut2 = CGRect(x: 110, y: 120, width: 10, height: 20)
        XCTAssertEqual(sut2.centerTop, CGPoint(x: 115, y: 120))
    }



    func test_centerBottom () {
        let sut1 = CGRect(x: 10, y: 20, width: 100, height: 200)
        XCTAssertEqual(sut1.centerBottom, CGPoint(x: 60, y: 220))

        let sut2 = CGRect(x: 110, y: 120, width: 10, height: 20)
        XCTAssertEqual(sut2.centerBottom, CGPoint(x: 115, y: 140))
    }

}
