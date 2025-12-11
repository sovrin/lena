//
//  ContentView.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct ContentView: View {

    @State
    private var text: String = ""

    @FocusState
    private var focused

    var body: some View {
        HStack {
            HStack(spacing: 16) {
                Image(systemName: "translate")
                    .resizable()
                    .frame(width: 24, height: 24)

                TextField("Translate", text: $text)
                    .font(.title)
                    .textFieldStyle(.plain)
                    .focused($focused)
            }
            .padding()
        }
        .glassEffect(.clear)
        .padding()
        .onAppear {
            focused = true
        }
    }
}

#Preview {
    ContentView()
}
