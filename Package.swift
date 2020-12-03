// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "libsmb2",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "libsmb2",
            targets: ["libsmb2"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "libsmb2",
            path: "./",
            exclude: ["cmake", "examples", "packaging", "tests", "README",
                      "bootstrap", "CMakeLists.txt", "component.mk", "configure.ac",
                      "COPYING", "libsmb2.pc.in", "LICENCE-LGPL-2.1.txt", "Makefile.am",
                      "lib/Makefile.am", "lib/Makefile.PS2_EE", "lib/Makefile.PS3_PPU",
                      "lib/libsmb2.syms", "lib/CMakeLists.txt", "include/Makefile.am"],
            publicHeadersPath: "include/umbrella",
            cSettings: [
                .headerSearchPath("include"),
                .define("HAVE_CONFIG_H", to: "1")
            ])
    ]
)
