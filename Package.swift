// swift-tools-version:5.3
// Package.swift
// UXComponents
//
// Created by John Hammerlund on 11/11/20.
// Copyright © 2020 MINDBODY. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "MBDebugPanel",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v9),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(name: "MBDebugPanel", targets: ["MBDebugPanel"])
    ],
    dependencies: [],
    targets: [
        .target(name: "MBDebugPanel",
                dependencies: [],
                exclude: ["SupportingFiles/Info-iOS.plist"],
                publicHeadersPath: "Headers")
    ]
)
