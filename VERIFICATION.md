# StoreKitHelper 升级验证指南

本文档提供了验证 StoreKitHelper 库从 `ObservableObject` 升级到 `@Observable` 的方法。

## 验证步骤

### 1. 代码检查

首先，确保以下文件已正确更新：

- `StoreContext.swift`：从 `ObservableObject` 更改为 `@Observable`，并移除所有 `@Published` 标记
- `ProductsListViewModel`：从 `ObservableObject` 更改为 `@Observable`，并移除所有 `@Published` 标记
- 所有使用 `@EnvironmentObject var store: StoreContext` 的视图：更改为 `@Environment(\.store) private var store`
- 环境键：添加了 `StoreContextKey` 和相关扩展

### 2. 运行测试应用程序

我们提供了一个测试应用程序，用于验证 `@Observable` 的实现是否正确。按照以下步骤运行测试应用程序：

1. 在 Xcode 中打开项目
2. 选择 `StoreKitHelperTestApp` 作为运行目标
3. 运行应用程序
4. 测试以下功能：
   - 点击"添加测试产品 ID"按钮，观察产品 ID 是否增加
   - 点击"模拟购买状态"按钮，观察购买状态是否改变
   - 点击"切换购买弹窗"按钮，观察弹窗状态是否改变
   - 检查子视图是否正确显示从环境中获取的 StoreContext 信息

### 3. 运行单元测试

我们还提供了单元测试，用于验证 `@Observable` 的实现是否正确：

1. 在 Xcode 中打开项目
2. 选择 `StoreKitHelperTests` 测试目标
3. 运行测试
4. 确保所有测试都通过

### 4. 集成到实际应用程序中

最后一步是将更新后的库集成到实际应用程序中，并验证其功能是否正常：

1. 更新依赖项以使用最新版本的 StoreKitHelper
2. 将所有 `@StateObject var store = StoreContext(...)` 更改为 `@State var store = StoreContext(...)`
3. 将所有 `.environmentObject(store)` 更改为 `.storeContext(store)`
4. 将所有 `@EnvironmentObject var store: StoreContext` 更改为 `@Environment(\.store) private var store`
5. 更新所有使用 `store` 的代码，处理 `store` 可能为 `nil` 的情况（例如 `store?.property` 而不是 `store.property`）
6. 运行应用程序，确保所有功能正常工作

## 常见问题

### Q: 为什么我的应用程序无法编译？

A: 确保你已经更新了所有使用 `StoreContext` 的代码。特别注意以下几点：
- `@StateObject` 改为 `@State`
- `.environmentObject(store)` 改为 `.storeContext(store)`
- `@EnvironmentObject var store: StoreContext` 改为 `@Environment(\.store) private var store`
- 处理 `store` 可能为 `nil` 的情况

### Q: 为什么我的应用程序在运行时崩溃？

A: 可能是因为你尝试访问 `nil` 的 `store`。确保在使用 `store` 之前检查它是否为 `nil`，或者使用可选链（例如 `store?.property`）。

### Q: 我的应用程序无法正确更新 UI，怎么办？

A: 确保你的视图正确订阅了 `store` 的变化。使用 `@Observable` 时，SwiftUI 会自动跟踪属性的访问，并在属性更改时更新视图。如果视图没有正确更新，可能是因为你没有在视图的 `body` 中访问相关属性。 