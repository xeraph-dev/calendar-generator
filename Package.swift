// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "calendar-generator",
    defaultLocalization: "en",
    products: [
        .library(name: "CGCore", targets: ["CGCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-markdown.git", branch: "0.3.0"),
    ],
    targets: [
        .target(
            name: "CGCore",
            dependencies: [],
            path: "Sources/Core/"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["CGCore"]
        ),
    ]
)
