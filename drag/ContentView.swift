//
//  ContentView.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    let target: DragTarget

    var body: some View {
        GeometryReader { reader in
            VStack {
                Image(nsImage: self.target.image)
                    .font(.largeTitle)
                    .foregroundStyle(.tint)
                Text(self.target.label)
            }
            .onDrag({ self.target.provider })
            .padding()
            .frame(width: reader.size.width, height: reader.size.height)
            .background(colorScheme == .dark ? Color(white: 0, opacity: 0.4) : Color(white: 1, opacity: 0.6)) 
            .border(.separator)
            .background(VisualEffectView(material: .hudWindow, blendingMode: .behindWindow))
            .cornerRadius(12)
            .ignoresSafeArea(.all, edges: [.top])
        }
    }
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = NSVisualEffectView.State.active
        visualEffectView.alphaValue = 0.96
        return visualEffectView
    }

    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}
