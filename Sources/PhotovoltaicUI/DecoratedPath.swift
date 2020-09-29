//
//  DecoratedPath.swift
//  SenecUI
//
//  Created by André Rohrbeck on 15.11.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import Foundation
import SwiftUI



internal protocol DecoratablePath {
    /// The width of the line (determining the size of the decoration.
    var lineWidth: CGFloat { get }

    /// Returns the angle in which the line start points in degrees.
    var startAngle: Angle { get }

    /// Returns the angle in whcih the line end points in degrees.
    var endAngle: Angle { get }

    /// Returns the point, where the path to be decorated starts.
    var startPoint: CGPoint { get }

    /// Returns the point, where the path to be decorated ends.
    var endPoint: CGPoint { get }

    func path(startInsetBy startInset: CGFloat, endInsetBy endInset: CGFloat) -> Path
}



internal struct DecoratedPath<Path: DecoratablePath, Start: LineEnd, End: LineEnd>: View {
    public let path: Path
    public let lineWidth: CGFloat
    public let startDecoration: Start?
    public let endDecoration: End?

    public var body: some View {
        ZStack(alignment: .topLeading) {
            path.path(startInsetBy: startDecoration?.inset(forLineWidth: lineWidth, size: 1.0) ?? 0.0,
                      endInsetBy: endDecoration?.inset(forLineWidth: lineWidth, size: 1.0) ?? 0.0)
                .stroke(lineWidth: lineWidth)
            if let startDecoration = startDecoration {
                startDecoration.path(forLineWidth: lineWidth, size: 1.0)
                    .rotation(path.startAngle, anchor: UnitPoint(x: 0.0, y: 0.0))
                    .offset(path.startPoint)
                    .fill()
            }
            if let endDecoration = endDecoration {
                endDecoration.path(forLineWidth: lineWidth, size: 1.0)
                    .rotation(path.endAngle, anchor: UnitPoint(x: 0.0, y: 0.0))
                    .offset(path.endPoint)
                    .fill()
            }
        }
    }
}


internal struct DecoratedPath_Previews: PreviewProvider {
    internal static var previews: some View {
        Group {
            CurvedLine(startPoint: CGPoint(x: 10.0, y: 10.0),
                       endPoint: CGPoint(x: 200.0, y: 100.0),
                       radius: 30.0,
                       startingDirection: .horizontally,
                       lineWidth: 2.0)
            DecoratedPath(path: CurvedLine(startPoint: CGPoint(x: 10.0, y: 10.0),
                                           endPoint: CGPoint(x: 200.0, y: 100.0),
                                           radius: 30.0,
                                           startingDirection: .horizontally,
                                           lineWidth: 2.0),
                          lineWidth: 10.0,
                          startDecoration: ArrowHead(length: 2.0, width: 2.0),
                          endDecoration: ArrowHead(length: 3.0, width: 3.0)).foregroundColor(.blue)

        }
    }
}
