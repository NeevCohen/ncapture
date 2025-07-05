// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedSwift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedSwift",
            targets: ["SharedSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SharedSwift",
            dependencies: ["snifferLib"],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        ),
    ]
)

#if DEBUG
package.targets.append(.binaryTarget(name: "snifferLib", path: "../build/lib/Debug/xcframeworks/snifferLib.xcframework"))
#else
package.targets.append(.binaryTarget(name: "snifferLib", path: "../build/lib/Release/xcframeworks/snifferLib.xcframework"))
#endif
