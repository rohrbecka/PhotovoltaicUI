//
//  BatteryViewPresentable.swift
//  SenecUI_iOS
//
//  Created by André Rohrbeck on 12.01.19.
//  Copyright © 2019 André Rohrbeck. All rights reserved.
//

import Foundation


/// The view model for a `BatteryView`.
public protocol BatteryViewPresentable {
    var stateOfCharge: Double { get }
}
