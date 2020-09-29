//
//  Direction.swift
//  SenecUI
//
//  Created by André Rohrbeck on 29.12.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import Foundation

/// An enum represeting either the `.horizontally` or `.vertically` `Direction`.
///
/// - Author: André Rohrbeck
/// - Copyright: André Rohrbeck © 2018
/// - Date: 2018-12-29
public enum Direction {
    /// The horizontal case.
    case horizontally

    /// The vertical case.
    case vertically

    /// The opposite case to `self` (`horizontally` in case of `self` being `vertically` and vice versa).
    public var other: Direction {
        switch self {
        case .horizontally: return .vertically
        case .vertically: return .horizontally
        }
    }
}
