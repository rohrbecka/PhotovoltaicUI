//
//  BatteryView.swift
//  SenecUI_iOS
//
//  Created by André Rohrbeck on 01.12.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import SwiftUI

public struct BatteryView: View {

    public let stateOfCharge: Double?

    public var body: some View {
        GeometryReader(content: { geometry in
            let dimension = min(geometry.size.width, geometry.size.height)
            Path(roundedRect: batteryRect.scaled(to: dimension), cornerRadius: cornerRadius(for: dimension))
                .stroke(lineWidth: strokeWidth(for: dimension))
            if let stateOfCharge = stateOfCharge {
                Path(chargeRect(stateOfCharge: stateOfCharge).scaled(to: dimension)).fill()
            } else {
                Path(chargeRect().scaled(to: dimension)).fill().opacity(0.3)
            }
            Path(roundedRect: plusPoleRect.scaled(to: dimension), cornerRadius: cornerRadius(for: dimension)).fill()
        })
    }
}


// MARK: - The geometry to draw
extension BatteryView {

    private func cornerRadius(for dimension: CGFloat) -> CGFloat {
        return 0.03 * dimension
    }

    private func strokeWidth(for dimension: CGFloat) -> CGFloat {
        return 0.03 * dimension
    }

    private var batteryRect: CGRect {
        CGRect(x: 0.07, y: 0.28, width: 0.8, height: 0.44)
    }


    private func chargeRect(stateOfCharge: Double = 1.0) -> CGRect {
        batteryRect
// TODO: add custom function!
//            .inset(by: EdgeInsets(top: 0.04,
//                                  leading: 0.04,
//                                  bottom: 0.04,
//                                  trailing: yInset(for: stateOfCharge) + 0.04))
    }

    private func yInset(for stateOfCharge: Double) -> CGFloat {
        (batteryRect.width - 0.08) * (1.0-CGFloat(stateOfCharge))
    }

    private var plusPoleRect: CGRect {
        CGRect(x: 0.86, y: 0.4, width: 0.1, height: 0.2)
    }
}


// MARK: - Helpers
extension CGRect {
    fileprivate func scaled(to dimension: CGFloat) -> CGRect {
        CGRect(x: self.minX * dimension,
               y: self.minY * dimension,
               width: self.width * dimension,
               height: self.height * dimension)
    }
}


// MARK: - Previews
internal struct BatteryView_Previews: PreviewProvider {
    internal static var previews: some View {
        Group {
            VStack {
                BatteryView(stateOfCharge: 0.7).frame(width: 100, height: 100).foregroundColor(.red)
                BatteryView(stateOfCharge: 0.7).frame(width: 50, height: 50).foregroundColor(.red)
                BatteryView(stateOfCharge: 0.7).frame(width: 20, height: 20).foregroundColor(.red)
            }
        }
    }
}


