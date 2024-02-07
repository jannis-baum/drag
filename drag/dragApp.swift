//
//  dragApp.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI

struct DragTarget {
    let provider: NSItemProvider
    let image: NSImage
    let label: String

    init?(filepath: String) {
        let url: URL? = {
            if filepath.starts(with: "/") {
                return URL(filePath: filepath)
            }
            guard let pwd = ProcessInfo.processInfo.environment["PWD"]
            else { return nil }
            var url = URL(filePath: pwd)
            url.append(path: filepath)
            return url
        }()
        guard let url = url else { return nil }
        let path = url.absoluteString.replacingOccurrences(of: "file://", with: "")

        guard FileManager.default.fileExists(atPath: path),
              let provider = NSItemProvider(contentsOf: url)
        else { return nil }

        self.provider = provider
        self.label = url.lastPathComponent
        self.image = NSWorkspace.shared.icon(forFile: path)
    }
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
        guard CommandLine.arguments.count > arg,
              let target = DragTarget(filepath: CommandLine.arguments[arg])
        else {
            fatalError("usage: drag FILE")
        }

        self.panel = PanelController()
        let view = ContentView(target: target)
        self.panel.contentView = NSHostingView(rootView: view)
        self.panel.makeKeyAndOrderFront(nil)
    }

    var body: some Scene {
        Settings {}
    }
}
