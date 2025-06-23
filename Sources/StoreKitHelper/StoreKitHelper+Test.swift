import SwiftUI
import StoreKit

/// 用于测试 StoreContext 的示例产品
enum TestProduct: String, InAppProduct {
    case lifetime = "test.lifetime"
    case monthly = "test.monthly"
    var id: String { rawValue }
}

/// 用于验证 @Observable 实现的测试视图
struct StoreKitHelperTestView: View {
    @State private var store = StoreContext(products: TestProduct.allCases)
    @State private var isShowingPurchasePopup = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("StoreKitHelper 测试")
                .font(.title)
            
            // 显示产品数量
            Text("产品数量: \(store.products.count)")
            
            // 显示已购买产品数量
            Text("已购买产品: \(store.purchasedProductIds.count)")
            
            // 测试产品 ID 更新
            Button("添加测试产品 ID") {
                store.productIds.append("test.new.product")
                print("产品 ID: \(store.productIds)")
            }
            
            // 测试购买状态
            Button("模拟购买状态") {
                // 模拟一个购买的产品 ID
                if store.purchasedProductIds.isEmpty {
                    store.purchasedProductIds = ["test.lifetime"]
                } else {
                    store.purchasedProductIds = []
                }
                print("已购买产品 ID: \(store.purchasedProductIds)")
            }
            
            // 测试弹窗状态
            Button("切换购买弹窗") {
                store.isShowingPurchasePopup.toggle()
                isShowingPurchasePopup = store.isShowingPurchasePopup
                print("弹窗状态: \(store.isShowingPurchasePopup)")
            }
            
            // 显示购买弹窗
            if isShowingPurchasePopup {
                Text("购买弹窗已显示")
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Divider()
            
            // 测试环境传递
            Text("测试环境传递")
                .font(.headline)
            
            StoreKitHelperTestChildView()
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .storeContext(store)
    }
}

/// 子视图，用于测试环境值传递
struct StoreKitHelperTestChildView: View {
    @Environment(\.store) private var store
    
    var body: some View {
        VStack(spacing: 10) {
            Text("子视图")
                .font(.headline)
            
            if let store = store {
                Text("环境传递成功")
                Text("产品数量: \(store.products.count)")
                Text("已购买: \(store.hasNotPurchased ? "否" : "是")")
            } else {
                Text("环境传递失败")
                    .foregroundColor(.red)
            }
        }
    }
} 