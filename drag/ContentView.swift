//
//  ContentView.swift
//  drag
//
//  Created by Jannis Baum on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let target: DragTarget

    var body: some View {
        VStack {
            Image(nsImage: self.target.image)
                .font(.largeTitle)
                .foregroundStyle(.tint)
            Text(self.target.label)
        }.onDrag({ self.target.provider })
        .padding()
    }
}
