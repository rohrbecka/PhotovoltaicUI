//
//  LabelledView.swift
//  SenecUI_iOS
//
//  Created by André Rohrbeck on 26.09.20.
//  Copyright © 2020 André Rohrbeck. All rights reserved.
//

import SwiftUI

/// A View, showing a main view with a text label on top and one at the bottom.
internal struct LabelledView<MainView: View>: View {

    /// The label at the top of the `mainView`.
    public let topLabel: Text

    /// The main view, which is labelled.
    public let mainView: MainView

    /// The label at the bottom of the `mainView`.
    public let bottomLabel: Text


    public var body: some View {
        VStack(spacing: 0) {
            topLabel.padding(0.0)
            mainView
            bottomLabel.padding(0.0)
        }
    }


    /// Creates a `LabelledView`.
    ///
    /// - Parameter view: The `View` to be labelled.
    /// - Parameter top: The `String` to be displayed as the top label.
    /// - Parameter bottom: The `String` to be displayed as the bottom label.
    public init(_ view: MainView, top: String, bottom: String) {
        self.topLabel = Text(top)
        self.mainView = view
        self.bottomLabel = Text(bottom)
    }
}



internal struct LabelledView_Previews: PreviewProvider {
    internal static var previews: some View {
        Group {
            LabelledView(Image("house"),
                         top: "170 W",
                         bottom: "180 W").font(.system(size: 30.0))
        }
    }
}
