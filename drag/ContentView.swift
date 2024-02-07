//
//  ContentView.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .onDrag({
                    NSItemProvider(contentsOf: URL(fileURLWithPath: "/Users/jannisbaum/Desktop/test.jpeg"))!
                })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
