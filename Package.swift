// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CombineExtensionKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "CombineExtensionKit",
            targets: ["CombineExtensionKit"]
        ),
        .library(
            name: "CombineTestExtensionKit",
            targets: ["CombineTestExtensionKit"]
        ),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "CombineExtensionKit",
            dependencies: []
        ),
        .target(
            name: "CombineTestExtensionKit",
            dependencies: []
        ),
    ]
)
