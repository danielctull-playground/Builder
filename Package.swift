// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Builder",
    products: [
        .library(name: "Builder", targets: ["Builder"]),
    ],
    targets: [
        .target(name: "Builder"),
        .testTarget(name: "BuilderTests", dependencies: ["Builder"]),
    ]
)
