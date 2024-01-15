// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "calendar-generator",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "cg", targets: ["CLI"]),
        .executable(name: "api", targets: ["API"]),
        .library(name: "CGCore", targets: ["CGCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", from: "0.3.0"),
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.14.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
        .package(url: "https://github.com/swift-cloud/Vercel.git", from: "2.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLI",
            dependencies: [
                "CGCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .executableTarget(
            name: "API",
            dependencies: [
                .product(name: "Vercel", package: "Vercel"),
                .product(name: "VercelVapor", package: "Vercel"),
                .product(name: "Plot", package: "plot"),
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
