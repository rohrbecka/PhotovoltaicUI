//
//  EnergyFlowView.swift
//  SenecUI_iOS
//
//  Created by André Rohrbeck on 29.11.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import SwiftUI


public struct EnergyFlowView: View {

    public let model: EnergyFlowViewPresentable

//    public let tintColor: Color

    @State private var anchors = [AnchorType: CGRect]()

    public var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        HStack(alignment: .top) {
                            Spacer()
                            LabelledView(pvModuleImage(size: iconSize(geometry)),
                                         top: powerString(model.photovoltaicPowerGeneration),
                                         bottom: "")
                                .padding()
                                .storeAnchor(.bounds, as: .pvBounds, geometry: geometry)
                            Spacer()
                        }
                        Spacer()
                    }
                    HStack {
                        LabelledView(BatteryView(stateOfCharge: model.stateOfCharge)
                                        .frame(width: iconSize(geometry), height: iconSize(geometry)),
                                     top: powerString(model.photovoltaicToBatteryValue),
                                     bottom: powerString(model.batteryToHouseValue))
                            .padding()
                            .storeAnchor(.bounds, as: .batteryBounds, geometry: geometry)
                        Spacer()
                        LabelledView(gridImage(size: iconSize(geometry)),
                                     top: powerString(model.photovoltaicToGridValue),
                                     bottom: powerString(model.gridToHouseValue))
                            .padding()
                            .storeAnchor(.bounds, as: .gridBounds, geometry: geometry)
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            LabelledView(houseImage(size: iconSize(geometry)),
                                         top: powerString(model.photovoltaicToHouseValue),
                                         bottom: powerString(model.houseConsumption))
                                .padding()
                                .storeAnchor(.bounds, as: .houseBounds, geometry: geometry)
                            Spacer()
                        }
                    }
                }
            }
            arrow(from: anchors[.pvBounds]?.centerLeft,
                  to: anchors[.batteryBounds]?.centerTop,
                  starting: .horizontally,
                  power: model.photovoltaicToBatteryValue)
            arrow(from: anchors[.pvBounds]?.centerRight,
                  to: anchors[.gridBounds]?.centerTop,
                  starting: .horizontally,
                  power: model.photovoltaicToGridValue)
            arrow(from: anchors[.pvBounds]?.centerBottom,
                  to: anchors[.houseBounds]?.centerTop,
                  starting: .vertically,
                  power: model.photovoltaicToHouseValue)
            arrow(from: anchors[.batteryBounds]?.centerRight,
                  to: anchors[.gridBounds]?.centerLeft,
                  starting: .horizontally,
                  power: model.batteryToGridValue)
            arrow(from: anchors[.batteryBounds]?.centerBottom,
                  to: anchors[.houseBounds]?.centerLeft,
                  starting: .vertically,
                  power: model.batteryToHouseValue)
            arrow(from: anchors[.gridBounds]?.centerBottom,
                  to: anchors[.houseBounds]?.centerRight,
                  starting: .vertically,
                  power: model.gridToHouseValue)
        }
        .onPreferenceChange(BoundsPreferences.self, perform: { values in
            self.anchors = values
        })
    }
}



// MARK: - Geometry
extension EnergyFlowView {
    /// Returns the size of the icons, based on the size provided by the `geometry`.
    private func iconSize(_ geometry: GeometryProxy) -> CGFloat {
        geometry.minDimension / 4.5
    }



    /// Returns the line width for a certain amount of power.
    private func lineWidth (forPower power: Double) -> CGFloat {
        let normalizedPower = abs(power / model.maxValue)
        return EnergyFlowView.normalizedLineWidth(forNormalizedPower: normalizedPower) * 30.0
    }



    public static func normalizedLineWidth (forNormalizedPower power: Double) -> CGFloat {
        return CGFloat(log(power + 1.0) / log(2.0))
    }
}



extension GeometryProxy {
    var minDimension: CGFloat {
        min(size.height, size.width)
    }


    var maxDimension: CGFloat {
        max(size.height, size.width)
    }
}



// MARK: - Subviews
extension EnergyFlowView {
    private func arrow(from start: CGPoint?,
                       to end: CGPoint?,
                       starting direction: Direction,
                       power: Double) -> some View {
        if let start = start, let end = end {
            let lineWidth = self.lineWidth(forPower: power)
            let line = CurvedLine(startPoint: start,
                                  endPoint: end,
                                  radius: 30.0,
                                  startingDirection: direction,
                                  lineWidth: lineWidth)
            let startDecoration: ArrowHead?
            let endDecoration: ArrowHead?
            if power > 0 {
				startDecoration = nil
                endDecoration = ArrowHead(length: 1.2, width: 2.5)
            } else {
                startDecoration = ArrowHead(length: 1.2, width: 2.5)
                endDecoration = nil
            }
            return AnyView(DecoratedPath(path: line,
                                 lineWidth: lineWidth,
                                 startDecoration: startDecoration,
                                 endDecoration: endDecoration))
        } else {
            return AnyView(EmptyView())
        }
    }
}



// MARK: - Anchors
extension View {
    fileprivate func storeAnchor(_ bound: Anchor<CGRect>.Source,
                                 as key: AnchorType,
                                 geometry: GeometryProxy) -> some View {
        self.anchorPreference(
            key: BoundsPreferences.self,
            value: bound,
            transform: {[key: geometry[$0]]})
    }
}



/// The keys for the anchors between which the arrows are drawn.
private enum AnchorType: Hashable {
    case pvBounds
    case batteryBounds
    case gridBounds
    case houseBounds
}



/// The preference key to hold all the CGPoints serving as anchors for drawing the arrows.
private struct BoundsPreferences: PreferenceKey {
    public typealias Value = [AnchorType: CGRect]
    public static var defaultValue: Value = [:]

    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: { $1 }) // overwrite with the new value
    }
}



// MARK: Icons
extension EnergyFlowView {
    private func pvModuleImage(size: CGFloat) -> some View {
        Image("pv", bundle: Bundle.module)
            .renderingMode(.template)
            .resizable()
            .frame(width: size, height: size)
    }



    private func houseImage(size: CGFloat) -> some View {
        Image("house", bundle: Bundle.module)
            .renderingMode(.template)
            .resizable()
            .frame(width: size, height: size)
    }



    private func gridImage(size: CGFloat) -> some View {
        Image("grid", bundle: Bundle.module)
            .renderingMode(.template)
            .resizable()
            .frame(width: size, height: size)
    }
}



// MARK: - Labels
extension EnergyFlowView {
    private func powerString (_ power: Double?) -> String {
        guard let power = power else { return "–" }
        let formatter = NumberFormatter()
        if power < 1000 {
            formatter.maximumFractionDigits = 0
        } else {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        }
        let conversion = unitForValue(power)
        formatter.positiveSuffix = conversion.unit
        return ("\(formatter.string(from: power * conversion.multiplier as NSNumber) ?? "–")")
    }



    private func unitForValue (_ value: Double?) -> (unit: String, multiplier: Double) {
        guard let value = value else { return (unit: "-", multiplier: 0.0) }
        var unit = ""
        var multiplier = 1.0
        if value < 1000 {
            unit = model.unit
            multiplier = 1.0
        } else {
            unit = "k" + (model.unit)
            multiplier = 0.001
        }
        return (unit: " " + unit, multiplier: multiplier)
    }
}


// MARK: -
// MARK: - Previews
internal struct EnergyFlowView_Previews: PreviewProvider {
    internal static var previews: some View {
        Group {
            EnergyFlowView(model: MockEnergyFlow()).foregroundColor(.blue)
            EnergyFlowView(model: MockEnergyFlow(maxValue: 1,
                                                 photovoltaicToBatteryValue: 1,
                                                 photovoltaicToGridValue: 1,
                                                 photovoltaicToHouseValue: 1,
                                                 batteryToGridValue: -1,
                                                 batteryToHouseValue: -1,
                                                 gridToHouseValue: -1,
                                                 unit: "W",
                                                 stateOfCharge: 1)).foregroundColor(.red)
        }
    }
}



internal struct MockEnergyFlow: EnergyFlowViewPresentable {
    internal var maxValue = 7000.0

    internal var photovoltaicToBatteryValue = 2430.0

    internal var photovoltaicToGridValue = 600.0

    internal var photovoltaicToHouseValue = 523.3

    internal var batteryToGridValue = 0.0

    internal var batteryToHouseValue = 0.0

    internal var gridToHouseValue = 0.0

    internal var unit = "W"

    internal var stateOfCharge = 0.3
}
