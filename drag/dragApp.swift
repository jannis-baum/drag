//
//  dragApp.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI

enum DragTargetError: LocalizedError {
    case noCwd
    case nonExistingFile(String)

    var errorDescription: String? {
        switch self {
        case .noCwd: "Could not determine current working directory"
        case let .nonExistingFile(file): "File \"\(file)\" does not exist"
        }
    }
}

struct DragTarget {
    let provider: NSItemProvider
    let image: NSImage
    let label: String

    init(filepath: String) throws {
        let url: URL = try {
            let tildeResolved = filepath.replacingOccurrences(of: "~", with: NSHomeDirectory())
            if tildeResolved.starts(with: "/") {
                return URL(filePath: tildeResolved)
            }
            guard let pwd = ProcessInfo.processInfo.environment["PWD"]
            else { throw DragTargetError.noCwd }
            var url = URL(filePath: pwd)
            url.append(path: filepath)
            return url
        }()
        let path = url.path(percentEncoded: false)

        guard FileManager.default.fileExists(atPath: path),
              let provider = NSItemProvider(contentsOf: url)
        else { throw DragTargetError.nonExistingFile(path) }

        self.provider = provider
        self.label = url.lastPathComponent
        self.image = NSWorkspace.shared.icon(forFile: path)
    }
}

func printUsage() {
    print("usage: \(CommandLine.arguments[0]) FILE")
}

@main
struct dragApp: App {
    let panel: PanelController

    init() {
        #if DEBUG
        let arg = 0
        #else
        let arg = 1
        #endif
        guard CommandLine.arguments.count > arg else {
            printUsage()
            exit(1)
        }

        let target = {
            do {
                return try DragTarget(filepath: CommandLine.arguments[arg])
            } catch {
                print(error.localizedDescription)
                printUsage()
                exit(1)
            }
        }()

        self.panel = PanelController()
        let view = ContentView(target: target)
        self.panel.contentView = NSHostingView(rootView: view)
        self.panel.makeKeyAndOrderFront(nil)
    }

    var body: some Scene {
        Settings {}
    }
}
