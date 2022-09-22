// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncAwaitBenchmarks" ,
    platforms: [.macOS(.v12), .iOS(.v13)],
    products: [
        .executable(name: "Benchmarks", targets: ["Benchmarks"])
    ],
    dependencies: [
      .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "Benchmarks",
            dependencies: [.product(name: "Benchmark", package: "swift-benchmark")]
        )
    ]
)
