// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "combine-schedulers",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "CombineSchedulers",
      targets: ["CombineSchedulers"]
    )
  ],
  traits: [
    .default(enabledTraits: ["OpenCombineSchedulers"]),
    Trait(
      name: "OpenCombineSchedulers",
      description: "Support for Combine on non-Apple platforms using OpenCombine."
    ),
  ],
  dependencies: [
    .package(path: "../swift-concurrency-extras"),
    .package(path: "../xctest-dynamic-overlay"),
    .package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.14.0"),
  ],
  targets: [
    .target(
      name: "CombineSchedulers",
      dependencies: [
        .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
        .product(
          name: "OpenCombineShim",
          package: "OpenCombine",
          condition: .when(platforms: [.linux, .android], traits: ["OpenCombineSchedulers"])
        ),
      ]
    ),
    .testTarget(
      name: "CombineSchedulersTests",
      dependencies: [
        "CombineSchedulers"
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
