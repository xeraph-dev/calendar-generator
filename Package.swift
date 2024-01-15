// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "calendar-generator",
    defaultLocalization: "en",
    products: [
        .library(name: "CGCore", targets: ["CGCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", branch: "0.3.0"),
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.14.0"),
    ],
    targets: [
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
