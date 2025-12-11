//
//  HotkeyView.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct HotkeyView: View {

    @State
    private var text: String = ""

    @FocusState
    private var focused

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 24, height: 24)

            TextField("Translate", text: $text)
                .font(.title)
                .textFieldStyle(.plain)
                .focused($focused)
        }
        .padding()
        .frame(width: 400)
        .background(.ultraThinMaterial)
        .onAppear {
            focused = true
        }
    }
}
