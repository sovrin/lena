//
//  SettingsScreen.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI
import KeyboardShortcuts

struct SettingsScreen: View {
    @AppStorage("serverEndpoint") private var serverEndpoint: String = "http://localhost:3000"

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Open Hotkey Window")
                    KeyboardShortcuts.Recorder(for: .openHotkeyWindow)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Server Endpoint")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 8) {
                        TextField("http://localhost:3000", text: $serverEndpoint)
                            .textFieldStyle(.roundedBorder)
                            .font(.body)
                            .disableAutocorrection(true)
                            .monospaced()

                        // Optional: a reset button
                        Button("Reset") {
                            serverEndpoint = "http://localhost:3000"
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
