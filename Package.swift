// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let macOSVersion: SupportedPlatform.MacOSVersion = .v10_15
#else
let macOSVersion: SupportedPlatform.MacOSVersion = .v10_10
#endif

#if os(Linux)
let extraPackageDependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.2")
]
#else
let extraPackageDependencies: [Package.Dependency] = []
#endif

#if os(Linux)
let extraTargetDependencies: [Target.Dependency] = [
    .product(name: "Crypto", package: "swift-crypto")
]
#else
let extraTargetDependencies: [Target.Dependency] = []
#endif

let package = Package(
    name: "AlgoliaSearchClient",
    platforms: [
        .iOS(.v9),
        .macOS(macOSVersion),
        .watchOS(.v2),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "Core", targets: ["Core"]),
        .library(name: "AccountClient", targets: ["AccountClient"]),
        .library(name: "AnalyticsClient", targets: ["AnalyticsClient"]),
        .library(name: "InsightsClient", targets: ["InsightsClient"]),
        .library(name: "RecommendClient", targets: ["RecommendClient"]),
        .library(name: "PersonalizationClient", targets: ["PersonalizationClient"]),
        .library(name: "PlacesClient", targets: ["PlacesClient"]),
        .library(name: "SearchClient", targets: ["SearchClient"]),
        .library(name: "AlgoliaSearchClient", targets: ["AlgoliaSearchClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0")
    ] + extraPackageDependencies,
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ] + extraTargetDependencies),
        .target(
            name: "AccountClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "AnalyticsClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "InsightsClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "RecommendClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "PersonalizationClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "PlacesClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "SearchClient",
            dependencies: ["Core"]
        ),
        .target(
            name: "AlgoliaSearchClient",
            dependencies: [
                "AccountClient",
                "AnalyticsClient",
                "InsightsClient",
                "RecommendClient",
                "PersonalizationClient",
                "PlacesClient",
                "SearchClient"
            ]
        ),
        
        //        .testTarget(
        //            name: "AlgoliaSearchClientTests",
        //            dependencies: [
        //                .target(name: "AlgoliaSearchClient"),
        //                .product(name: "Logging", package: "swift-log")
        //            ] + extraTargetDependencies)
    ]
)
