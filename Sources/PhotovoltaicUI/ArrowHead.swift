//
//  ArrowHead.swift
//  SenecClient
//
//  Created by André Rohrbeck on 31.10.18.
//

import SwiftUI


/// A struct representing the head of an arrow, which is usually used as
/// the end of a line.
///
/// The `ArrowHead` describes the head of the arrow in a "100%"-size and
/// pointing to the left (in negative x direction). The tip of the
/// arrow head is at (0|0).
///
/// This type is intended to be extended on different platforms to return
/// the path representing the `ArrowHead`. The path consists of lines
/// from the `headPoint` to the `leftTip`, to the `rearEnd`, to the `rightTip`
/// and back to the `headPoint`.
///
/// Author:     André Rohrbeck
/// Date:       2018-11-06
/// Copyright:  André Rohrbeck
public struct ArrowHead {

    /// The distance from the head of the arrow to its end on the left side looking in
    /// the direction of the `ArrowHead`.
    public let leftLength: CGFloat

    /// The distance from the head of the arrow to its end on the right side looking in
    /// the direction of the `ArrowHead`.
    public let rightLength: CGFloat

    /// The distance from the head of the arrow to its end in the cneter line of the
    /// `ArrowHead`.
    public let centerLength: CGFloat

    /// The distance from the center line to the left end of the arrow.
    public let leftWidth: CGFloat

    /// The distance from the center line to the right end of the arrow.
    public let rightWidth: CGFloat


    /// Default Initializer.
    ///
    /// The measures define the nominal size of the `ArrowHead` usually in relation to
    /// the line width.
    public init (centerLength: CGFloat,
                 leftLength: CGFloat,
                 rightLength: CGFloat,
                 leftWidth: CGFloat,
                 rightWidth: CGFloat) {
        self.centerLength = centerLength
        self.leftLength = leftLength
        self.rightLength = rightLength
        self.leftWidth = leftWidth
        self.rightWidth = rightWidth
    }



    /// Initializes a symmetric `ArrowHead` with a flat end, with a given `length`
    /// and `width`. Dimensions are representing the 100-%-scaling.
    public init (length: CGFloat = 2, width: CGFloat = 1.5) {
        self.leftLength = length
        self.centerLength = length
        self.rightLength = length
        self.leftWidth = width/2.0
        self.rightWidth = width/2.0
    }



    public init (centerLength: CGFloat, sideLength: CGFloat, width: CGFloat) {
        self.leftLength = sideLength
        self.centerLength = centerLength
        self.rightLength = sideLength
        self.leftWidth = width/2.0
        self.rightWidth = width/2.0
    }


    // MARK: - points in the ArrowHead
    /// Returns the point represnting the tip of the `ArrowHead`.
    public var headPoint: CGPoint {
        return CGPoint(x: 0.0, y: 0.0)
    }



    /// Returns the point representing the left tip of the `ArrowHead`.
    public var leftTip: CGPoint {
        return CGPoint(x: leftLength, y: -leftWidth)
    }


    /// Returns the point representing the right top of the `ArrowHead`.
    public var rightTip: CGPoint {

        return CGPoint(x: rightLength, y: rightWidth)
    }


    /// Returns the end point of the `ArrrowHead`, which is on the center line.
    public var rearEnd: CGPoint {
        return CGPoint(x: centerLength, y: 0.0)
    }
}



extension ArrowHead: LineEnd {
    public var path: Path {
        Path { path in
            path.move(to: headPoint)
            path.addLine(to: leftTip)
            path.addLine(to: rearEnd)
            path.addLine(to: rightTip)
            path.closeSubpath()
        }
    }

    public var inset: CGFloat {
        centerLength
    }
}



internal struct ArrowHead_Previews: PreviewProvider {
    internal static var previews: some View {
        ArrowHead(length: 15, width: 10).path
    }
}
