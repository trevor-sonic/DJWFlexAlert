// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DJWFlexAlert",
    
    platforms: [
        .iOS(.v13),
        .macOS(.v10_12),
        .tvOS(.v10)
    ],
    
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DJWFlexAlert",
            targets: ["DJWFlexAlert"]),
    ],
    dependencies: [
        .package(url: "https://github.com/trevor-sonic/DJWCommon.git", from: "1.0.0"),
        .package(url: "https://github.com/trevor-sonic/DJWBaseVC.git", from: "1.0.0"),
        .package(url: "https://github.com/trevor-sonic/DJWKeyboardTools.git", from: "1.0.0"),
        .package(url: "https://github.com/trevor-sonic/DJWUIBuilder.git", from: "1.0.0"),
        .package(url: "https://github.com/trevor-sonic/DJWBuilderNS.git", from: "1.0.0"),
        
        ///public
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "DJWFlexAlert",
            dependencies: [
                "DJWCommon",
                "DJWBaseVC",
                "DJWKeyboardTools",
                "DJWUIBuilder",
                "DJWBuilderNS",
                
                ///public
                "SnapKit"
        ]),
        .testTarget(
            name: "DJWFlexAlertTests",
            dependencies: ["DJWFlexAlert"]),
    ]
)
