// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "podle",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "podle",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "BigInt", package: "BigInt")
            ]),
        .testTarget(
            name: "podleTests",
            dependencies: ["podle"]),
    ]
)
