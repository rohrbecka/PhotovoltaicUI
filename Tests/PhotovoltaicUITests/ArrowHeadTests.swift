//
//  File.swift
//  
//
//  Created by André Rohrbeck on 29.09.20.
//

import XCTest
@testable import PhotovoltaicUI

class ArrowHeadTests: XCTestCase {

    func testPathReturnsCorrectRawArrow () {
        let sut = ArrowHead(centerLength: 1.5,
                            leftLength: 2.0,
                            rightLength: 1.8,
                            leftWidth: 1.0,
                            rightWidth: 0.9)
        let path = sut.path

        // attention in mac OS the y axis goes from top to bottom, arrow points to the left
        XCTAssert(path.contains(CGPoint(x: 0, y: 0)))
        XCTAssert(path.contains(CGPoint(x: 2.0, y: -1.0)))
        XCTAssert(path.contains(CGPoint(x: 1.5, y: 0.0)))
        XCTAssert(path.contains(CGPoint(x: 1.8, y: 0.9)))
    }
}
