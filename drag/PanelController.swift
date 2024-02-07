//
//  PanelController.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI

class PanelController: NSPanel {
    init() {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 128, height: 128),
            styleMask: [.nonactivatingPanel, .titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        self.center()
        // float above all other windows
        self.isFloatingPanel = true
        self.level = .floating
        // appear in a fullscreen space
        self.collectionBehavior.insert(.fullScreenAuxiliary)
        // title
        self.title = "Drag"
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        // hide traffic icons
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        // transparency
        self.backgroundColor = .clear

        // regrab key focus if lost (for example when activated app is quit)
        NotificationCenter.default.addObserver(
            self, selector: #selector(windowLostKey),
            name: NSWindow.didResignKeyNotification, object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func windowLostKey(_ notification: NSNotification) {
        NSApp.terminate(self)
    }
}
