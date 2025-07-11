// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftHelper",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftHelper",
            targets: ["SwiftHelper"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apphud/ApphudSDK.git", .upToNextMajor(from: "3.5.8")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0"))
    ],
    targets: [
        .target(
            name: "SwiftHelper",
            dependencies: [
                .product(name: "ApphudSDK", package: "ApphudSDK"),
                .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "Sources"
        )
    ]
)


