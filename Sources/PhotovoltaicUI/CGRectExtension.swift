//
//  CGRectExtension.swift
//  SenecUI_iOS
//
//  Created by André Rohrbeck on 12.01.19.
//  Copyright © 2019 André Rohrbeck. All rights reserved.
//

import Foundation

public extension CGRect {
    /// The center point on the left edge of the `CGRect`.
    var centerLeft: CGPoint {
        return CGPoint(x: minX, y: minY + height/2.0)
    }



    /// The center point on the right edge of the `CGRect`.
    var centerRight: CGPoint {
        return CGPoint(x: maxX, y: minY + height/2.0)
    }



    /// The center point on the top edge of the `CGRect`.
    var centerTop: CGPoint {
        return CGPoint(x: minX + width/2.0, y: minY)
    }



    /// The center point on the bottom edge of the `CGRect`.
    var centerBottom: CGPoint {
        return CGPoint(x: minX + width/2.0, y: maxY)
    }
}
