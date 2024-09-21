// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GaugeKit",
    platforms: [
        .macOS(.v11), .iOS(.v13), .watchOS(.v6), .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GaugeKit",
            targets: ["GaugeKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GaugeKit",
            dependencies: []
        ),
        .testTarget(
            name: "GaugeKitTests",
            dependencies: ["GaugeKit"]
        ),
    ]
)
