// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorCommunityWebviewgenie",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorCommunityWebviewgenie",
            targets: ["webviewgeniePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "webviewgeniePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/webviewgeniePlugin"),
        .testTarget(
            name: "webviewgeniePluginTests",
            dependencies: ["webviewgeniePlugin"],
            path: "ios/Tests/webviewgeniePluginTests")
    ]
)