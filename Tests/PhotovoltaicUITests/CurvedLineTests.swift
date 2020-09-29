//
//  CurvedLine_iOSTests.swift
//  SenecUI_iOSTests
//
//  Created by André Rohrbeck on 15.11.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import XCTest
import SwiftUI
@testable import PhotovoltaicUI

class CurvedLineTests: XCTestCase {

    func testPathReturnsCorrectLine () {
        let startingPoint = CGPoint(x: 50.0, y: 40.0)
        let endPoint = CGPoint(x: 260, y: 180.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             radius: 10.0,
                             startingDirection: .vertically,
                             lineWidth: 15.0)

        let path = sut.path

        XCTAssert(path.contains(startingPoint))
        XCTAssert(path.contains(endPoint))
        XCTAssert(path.contains(CGPoint(x: 50.0, y: 170.0)))
        XCTAssert(path.contains(CGPoint(x: 60.0, y: 180.0)))
        XCTAssertEqual(15.0, sut.lineWidth)
    }


    // MARK: - Testing of DecoratablePath implementation
    func testCurvedLineImplementsDecoratablePath () {
        let startingPoint = CGPoint(x: 50.0, y: 40.0)
        let endPoint = CGPoint(x: 260, y: 180.0)
        let sut: Any = CurvedLine(startPoint: startingPoint, endPoint: endPoint)

        XCTAssert(sut is DecoratablePath)
    }



    func testStartPointAndEndPointImplementation () {
        let startingPoint = CGPoint(x: 50.0, y: 40.0)
        let endPoint = CGPoint(x: 260, y: 180.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint)

        XCTAssertEqual(sut.startPoint, sut.startPoint)
        XCTAssertEqual(sut.endPoint, sut.endPoint)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_1 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 100, y: 100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .horizontally)

        XCTAssertEqual(Angle(degrees: 0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 270.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_2 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 100, y: -100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .horizontally)

        XCTAssertEqual(Angle(degrees: 0.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 90.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_3 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: -100, y: -100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .horizontally)

        XCTAssertEqual(Angle(degrees: 180.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 90.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_4 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: -100, y: 100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .horizontally)

        XCTAssertEqual(Angle(degrees: 180.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 270.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_5 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 100, y: 100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .vertically)

        XCTAssertEqual(Angle(degrees: 90.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 180.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_6 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 100, y: -100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .vertically)

        XCTAssertEqual(Angle(degrees: 270.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 180.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_7 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: -100, y: -100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .vertically)

        XCTAssertEqual(Angle(degrees: 270.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 0.0), sut.endAngle)
    }



    func testStartAngleAndEndAngleReturnCorrectValues_8 () {
        let startingPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: -100, y: 100.0)
        let sut = CurvedLine(startPoint: startingPoint,
                             endPoint: endPoint,
                             startingDirection: .vertically)

        XCTAssertEqual(Angle(degrees: 90.0), sut.startAngle)
        XCTAssertEqual(Angle(degrees: 0.0), sut.endAngle)
    }
}
