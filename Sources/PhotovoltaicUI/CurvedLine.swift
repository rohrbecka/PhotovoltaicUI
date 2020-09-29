//
//  CurvedLine.swift
//  SenecUI
//
//  Created by André Rohrbeck on 09.11.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import SwiftUI


public struct CurvedLine: View {

    /// The point, where the `CurvedLine` starts.
    public let startPoint: CGPoint

    /// The point, where the `CurvedLine` ends.
    public let endPoint: CGPoint

    /// The radius, which is drawn between the two lines.
    public var radius: CGFloat = 0

    /// The radius, which should be used when drawing.
    ///
    /// Normally the `radius` is returned. If the geometry of the path
    /// doesn't allow this `radius`, the value is reduced and may become even
    /// 0.
    public var effectiveRadius: CGFloat {
        let horizontalSpace = abs(startPoint.x - endPoint.x)
        let verticalSpace = abs(startPoint.y - endPoint.y)
        return min(radius, horizontalSpace, verticalSpace)
    }

    /// The direction in which the drawing starts.
    ///
    /// Each `CurvedLine` has two options to be drawn, which can be differentiated
    /// by their `startingDirection`.
    public var startingDirection = Direction.horizontally

    /// The width of the line, which should be drawn.
    public var lineWidth: CGFloat = 1.0



    public var body: some View {
        path.stroke(lineWidth: lineWidth)
    }


    /// The path of the `CurvedLine`.
    public var path: Path {
        Path {path in
            path.move(to: startPoint)
            if effectiveRadius > 0 {
                path.addArc(center: radiusCenter,
                            radius: effectiveRadius,
                            startAngle: radiusStartAngle,
                            endAngle: radiusEndAngle,
                            clockwise: radiusClockwise)
            }
            path.addLine(to: endPoint)
        }
    }
}


// MARK: - Geometry Calculations
extension CurvedLine {
    fileprivate var radiusCenter: CGPoint {
        let radiusCenterX: CGFloat
        let radiusCenterY: CGFloat
        switch startingDirection {
        case .horizontally:
            if startPoint.x < endPoint.x {
                radiusCenterX = endPoint.x - effectiveRadius
            } else {
                radiusCenterX = endPoint.x + effectiveRadius
            }
            if startPoint.y < endPoint.y {
                radiusCenterY = startPoint.y + effectiveRadius
            } else {
                radiusCenterY = startPoint.y - effectiveRadius
            }
        case .vertically:
            if startPoint.x < endPoint.x {
                radiusCenterX = startPoint.x + effectiveRadius
            } else {
                radiusCenterX = startPoint.x - effectiveRadius
            }
            if startPoint.y < endPoint.y {
                radiusCenterY = endPoint.y - effectiveRadius
            } else {
                radiusCenterY = endPoint.y + effectiveRadius
            }
        }
        return CGPoint(x: radiusCenterX, y: radiusCenterY)
    }



    /// The starting angle of the arc connecting the horizontal and the vertical part of the line in degrees.
    fileprivate var radiusStartAngle: Angle {
        switch startingDirection {
        case .horizontally:
            if startPoint.y < endPoint.y {
                return Angle(degrees: -90.0)
            } else {
                return Angle(degrees: 90.0)
            }
        case .vertically:
            if startPoint.x < endPoint.x {
                return Angle(degrees: 180.0)
            } else {
                return Angle(degrees: 0.0)
            }
        }
    }



    /// The end angle of the arc connecting the horizontal and the vertical part of the line in degrees.
    fileprivate var radiusEndAngle: Angle {
        switch startingDirection {
        case .horizontally:
            if startPoint.x < endPoint.x {
                return Angle(degrees: 0.0)
            } else {
                return Angle(degrees: 180.0)
            }
        case .vertically:
            if startPoint.y < endPoint.y {
                return Angle(degrees: 90.0)
            } else {
                return Angle(degrees: -90.0)
            }
        }
    }



    /// Whether the arc connecting the horizontal and the vertical part of the line is drawn clockwise or
    /// counter-clockwise.
    fileprivate var radiusClockwise: Bool {
        let deltaAngle = normalizedAngle(radiusStartAngle.degrees - radiusEndAngle.degrees)
        return (deltaAngle > 0.0)
    }



    /// Returns the angle normalized to the range from -180 to 180 degrees.
    fileprivate func normalizedAngle (_ angle: Double) -> Double {
        var normalized = angle
        while normalized < -180.0 {
            normalized += 360.0
        }
        while normalized > 180.0 {
            normalized -= 360.0
        }
        return normalized
    }
}



// MARK: - Decoratable Path
extension CurvedLine: DecoratablePath {
    public func path(startInsetBy startInset: CGFloat, endInsetBy endInset: CGFloat) -> Path {
        let lineWithInsets = CurvedLine(startPoint: startPoint(withInset: startInset),
                                        endPoint: endPoint(withInset: endInset),
                                        radius: radius,
                                        startingDirection: startingDirection,
                                        lineWidth: lineWidth)
        return lineWithInsets.path
    }

    public var startAngle: Angle {
        switch startingDirection {
        case .horizontally:
            if endPoint.x > startPoint.x {
                return Angle(degrees: 0.0)
            } else if endPoint.x < startPoint.x {
                return Angle(degrees: 180.0)
            } else if endPoint.y < startPoint.x {
                return Angle(degrees: 270.0)
            } else {
                return Angle(degrees: 90.0)
            }
        case .vertically:
            if endPoint.y > startPoint.y {
                return Angle(degrees: 90.0)
            } else if endPoint.y < startPoint.y {
                return Angle(degrees: 270.0)
            } else if endPoint.x < startPoint.x {
                return Angle(degrees: 180.0)
            } else {
                return Angle(degrees: 0.0)
            }
        }
    }



    public var endAngle: Angle {
        switch startingDirection {
        case .horizontally:
            if endPoint.y > startPoint.y {
                return Angle(degrees: 270.0)
            } else if endPoint.y < startPoint.y {
                return Angle(degrees: 90.0)
            } else if endPoint.x < startPoint.x {
                return Angle(degrees: 0.0)
            } else {
                return Angle(degrees: 180.0)
            }
        case .vertically:
            if endPoint.x > startPoint.x {
                return Angle(degrees: 180.0)
            } else if endPoint.x < startPoint.x {
                return Angle(degrees: 0.0)
            } else if endPoint.y < startPoint.y {
                return Angle(degrees: 90.0)
            } else {
                return Angle(degrees: 270.0)
            }
        }
    }



    private func startPoint(withInset inset: CGFloat) -> CGPoint {
        switch startingDirection {
        case .horizontally:
            if startPoint.x < endPoint.x {
                return startPoint.offset(dx: inset)
            } else if startPoint.x > endPoint.x {
                return startPoint.offset(dx: -inset)
            } else if startPoint.y < endPoint.y {
                return startPoint.offset(dy: inset)
            } else {
                return startPoint.offset(dy: -inset)
            }
        case .vertically:
            return startPoint.y < endPoint.y
                ? startPoint.offset(dy: inset)
                : startPoint.offset(dy: -inset)
        }
    }


    private func endPoint(withInset inset: CGFloat) -> CGPoint {
        switch startingDirection {
        case .horizontally:
            if startPoint.y < endPoint.y {
                return endPoint.offset(dy: -inset)
            } else if startPoint.y > endPoint.y {
                return endPoint.offset(dy: inset)
            } else if startPoint.x < endPoint.x {
                return endPoint.offset(dx: -inset)
            } else {
                return endPoint.offset(dx: inset)
            }

        case .vertically:
            if startPoint.x < endPoint.x {
                return endPoint.offset(dx: -inset)
            } else if startPoint.x > endPoint.x {
                return endPoint.offset(dx: inset)
            } else if startPoint.y < endPoint.y {
                return endPoint.offset(dy: -inset)
            } else {
                return endPoint.offset(dy: inset)
            }
        }
    }
}



private extension CGPoint {
    // swiftlint:disable:next identifier_name
    func offset(dx: CGFloat = 0.0, dy: CGFloat = 0.0) -> CGPoint {
        CGPoint(x: x + dx, y: y + dy)
    }
}



// MARK: - Previews
internal struct CurvedLine_Previews: PreviewProvider {
    internal static var previews: some View {
        Group {
            ZStack {
                CurvedLine(startPoint: CGPoint(x: 10, y: 10),
                           endPoint: CGPoint(x: 200.0, y: 100.0),
                           radius: 10,
                           startingDirection: .horizontally,
                           lineWidth: 10).foregroundColor(.blue)
                CurvedLine(startPoint: CGPoint(x: 10, y: 10),
                           endPoint: CGPoint(x: 200.0, y: 100.0),
                           radius: 10,
                           startingDirection: .vertically,
                           lineWidth: 10).foregroundColor(.red)
            }
            
            ZStack {
                CurvedLine(startPoint: CGPoint(x: 10, y: 100),
                           endPoint: CGPoint(x: 200.0, y: 10.0),
                           radius: 10,
                           startingDirection: .horizontally,
                           lineWidth: 10).foregroundColor(.blue)
                CurvedLine(startPoint: CGPoint(x: 10, y: 100),
                           endPoint: CGPoint(x: 200.0, y: 10.0),
                           radius: 10,
                           startingDirection: .vertically,
                           lineWidth: 10).foregroundColor(.red)
            }
            
            CurvedLine(startPoint: CGPoint(x: 110, y: 200),
                       endPoint: CGPoint(x: 200.0, y: 100.0),
                       radius: 10,
                       startingDirection: .horizontally,
                       lineWidth: 10).foregroundColor(.blue)
            
            CurvedLine(startPoint: CGPoint(x: 110, y: 10),
                       endPoint: CGPoint(x: 200.0, y: 100.0),
                       radius: 10,
                       startingDirection: .horizontally,
                       lineWidth: 10).foregroundColor(.blue)
        }
    }
}
