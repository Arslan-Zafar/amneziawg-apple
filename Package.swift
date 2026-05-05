// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WireGuardKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(name: "AmneziaWireGuardKit", targets: ["WireGuardKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AmneziaWireGuardKit",
            dependencies: ["WireGuardKitGo", "WireGuardKitC"]
        ),
        .target(
            name: "AmneziaWireGuardKitC",
            dependencies: [],
            publicHeadersPath: "."
        ),
        .target(
            name: "AmneziaWireGuardKitGo",
            dependencies: [],
            exclude: [
                "goruntime-boottime-over-monotonic.diff",
                "go.mod",
                "go.sum",
                "api-apple.go",
                "api-xray.go",
                "Makefile"
            ],
            publicHeadersPath: ".",
            linkerSettings: [
                .unsafeFlags(["-L", "Sources/WireGuardKitGo/out"]),
                .linkedLibrary("wg-go"),
                .linkedLibrary("resolv")
            ]
        ),
        .testTarget(
            name: "WireGuardKitTests",
            dependencies: ["WireGuardKit"]
        )
    ]
)
