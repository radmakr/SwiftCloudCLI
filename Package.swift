// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftCloudCLI",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "swiftcloud",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
    ]
)
