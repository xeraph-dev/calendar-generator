// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "calendar-generator",
    defaultLocalization: "en",
    products: [
        .executable(name: "cg", targets: ["CLI"]),
        .library(name: "CGCore", targets: ["CGCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", from: "0.3.0"),
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.14.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLI",
            dependencies: [
                "CGCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "CGCore",
            dependencies: [
                .product(name: "Markdown", package: "swift-markdown"),
                .product(name: "Plot", package: "plot"),
            ],
            path: "Sources/Core/"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["CGCore"]
        ),
    ]
)
