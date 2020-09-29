//
//  LineEnd.swift
//  SenecClient
//
//  Created by André Rohrbeck on 06.11.18.
//

import SwiftUI


public protocol LineEnd {

    /// The inset for 100% scale at a line width of 1.0pt.
    var inset: CGFloat { get }

    /// The path for 100% scale at a line width of 1.0pt.
    var path: Path { get }
}



extension LineEnd {
    /// Returns the inset for a given size and line width of the `LineEnd`.
    ///
    /// In general a `LineEnd` scales linearily with the line width. Additionally
    /// a `size` may be specified to oversize (> 1.0) or undersize (< 1.0) the
    /// `LineEnd`. The parameters are just multiplied, but are making the
    /// API more concise as usually both parameters are treated individually.
    func inset(forLineWidth lineWidth: CGFloat, size: CGFloat) -> CGFloat {
        inset * lineWidth * size
    }

    func path(forLineWidth lineWidth: CGFloat, size: CGFloat) -> Path {
        let scale = lineWidth * size
        let scaling = CGAffineTransform(scaleX: scale, y: scale)
        return path.applying(scaling)
    }
}
