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
        if let screen = self.screen {
            self.setFrameTopLeftPoint(.init(x: 0, y: screen.visibleFrame.height))
        }
        // float above all other windows
        self.isFloatingPanel = true
        self.level = .mainMenu
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
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
