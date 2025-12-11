//
//  SettingsScreen.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI
import KeyboardShortcuts

struct SettingsScreen: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Open Hotkey Window")
                    KeyboardShortcuts.Recorder(for: .openHotkeyWindow)
                }
            }
            Spacer()
        }
        .padding()
    }
}
