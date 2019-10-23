// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "EtherFrame",
    patforms: [
        .macOS(.v10_13),
        .linux
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.8.1"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-SQLite", from: "2.0.1"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger", from: "1.9.0"),
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.1.10"),
        .package(url: "https://github.com/IBM-Swift/FileKit.git", from: "0.0.2"),
        .package(url: "https://github.com/twostraws/SwiftGD", from: "2.5.0"),
    ],
    targets: [
        .target(
            name: "EtherFrame",
            dependencies: [
                "Kitura",
                "SwiftKuerySQLite",
                "HeliumLogger",
                "SwiftyGPIO",
                "FileKit",
                "SwiftGD",
            ]
        ),
        .testTarget(
            name: "EtherFrameTests",
            dependencies: ["EtherFrame"]),
    ]
)
