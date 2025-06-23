//
//  RestorePurchasesButtonView.swift
//  StoreKitHelper
//
//  Created by wong on 3/28/25.
//

import SwiftUI
import Observation

// MARK: 恢复购买
/// 恢复购买
struct RestorePurchasesButtonView: View {
    @Environment(\.locale) var locale
    @Environment(\.popupDismissHandle) private var popupDismissHandle
    @Environment(\.store) private var store
    @Binding var restoringPurchase: Bool
    var body: some View {
        Button(action: {
            Task {
                restoringPurchase = true
                do {
                    try await store.restorePurchases()
                    restoringPurchase = false
                    if store.purchasedProductIds.count > 0 {
                        popupDismissHandle?()
                    } else {
                        Utils.alert(title: "no_purchase_available".localized(locale: locale), message: "")
                    }
                } catch {
                    restoringPurchase = false
                    Utils.alert(title: "restore_purchases_failed".localized(locale: locale), message: error.localizedDescription)
                }
            }
        }, label: {
            HStack {
                if restoringPurchase {
                    ProgressView().controlSize(.mini)
                }
                Text("restore_purchases".localized(locale: locale))
            }
        })
        #if os(macOS)
        .buttonStyle(.link)
        #endif
        .disabled(restoringPurchase)
    }
}
