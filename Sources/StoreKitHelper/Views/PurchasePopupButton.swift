//
//  BuyButton.swift
//  StoreKitHelper
//
//  Created by 王楚江 on 2025/3/4.
//

import SwiftUI
import Observation

public struct PurchasePopupButton<LabelView: View>: View {
    @Environment(\.store) private var store
    var label: (() -> LabelView)?
    public init(label: (() -> LabelView)? = nil) {
        self.label = label
    }
    public var body: some View {
        Button(action: {
            if let store = store {
                store.isShowingPurchasePopup.toggle()
            }
        }) {
            if let label {
                label()
            } else {
                Image(systemName: "cart")
            }
        }
    }
}

public extension PurchasePopupButton where LabelView == EmptyView {
    init() {
        self.init(label: nil)
    }
}
