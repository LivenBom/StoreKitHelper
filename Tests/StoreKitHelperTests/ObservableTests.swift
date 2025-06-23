import XCTest
@testable import StoreKitHelper

final class ObservableTests: XCTestCase {
    
    func testStoreContextObservable() {
        // 创建 StoreContext 实例
        let store = StoreContext(productIds: ["test.product1", "test.product2"])
        
        // 测试初始状态
        XCTAssertEqual(store.productIds.count, 2)
        XCTAssertEqual(store.productIds[0], "test.product1")
        XCTAssertEqual(store.productIds[1], "test.product2")
        XCTAssertTrue(store.purchasedProductIds.isEmpty)
        XCTAssertFalse(store.isShowingPurchasePopup)
        
        // 测试修改状态
        store.productIds.append("test.product3")
        XCTAssertEqual(store.productIds.count, 3)
        XCTAssertEqual(store.productIds[2], "test.product3")
        
        // 测试购买状态
        store.purchasedProductIds = ["test.product1"]
        XCTAssertEqual(store.purchasedProductIds.count, 1)
        XCTAssertEqual(store.purchasedProductIds[0], "test.product1")
        XCTAssertFalse(store.hasNotPurchased)
        
        // 测试弹窗状态
        store.isShowingPurchasePopup = true
        XCTAssertTrue(store.isShowingPurchasePopup)
    }
    
    func testProductsListViewModel() {
        // 创建 ProductsListViewModel 实例
        let viewModel = ProductsListViewModel()
        
        // 初始状态应为 nil
        XCTAssertNil(viewModel.filteredProducts)
        
        // 设置过滤器
        let testFilter: (String, Product) -> Bool = { productID, _ in
            return productID == "test.product"
        }
        
        viewModel.filteredProducts = testFilter
        
        // 验证过滤器已设置
        XCTAssertNotNil(viewModel.filteredProducts)
    }
} 