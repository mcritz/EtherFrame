// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "EtherFrame",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.8.1"),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-SQLite", from: "2.0.1"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger", from: "1.9.0"),
    ],
    targets: [
        .target(
            name: "EtherFrame",
            dependencies: [
                "Kitura",
                "SwiftKuerySQLite",
                "HeliumLogger",
            ]
        ),
        .testTarget(
            name: "EtherFrameTests",
            dependencies: ["EtherFrame"]),
    ]
)
