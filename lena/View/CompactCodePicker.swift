//
//  CompactCodePicker.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//
import SwiftUI

struct CompactCodePicker: View {
    @Binding var selection: String
    let options: [String]

    var body: some View {
        Menu {
            // Directly list options as buttons for reliability and compactness
            ForEach(options, id: \.self) { code in
                Button {
                    selection = code
                } label: {
                    // Mark the selected item
                    HStack {
                        Text(code.uppercased())
                        if code == selection {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Text(selection.uppercased())
                .font(.caption)
                .monospaced()
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(.thinMaterial, in: Capsule())
                .foregroundStyle(.secondary)
        }
        .menuStyle(.borderlessButton)
    }
}

#Preview {
    CompactCodePicker(
        selection: .constant("de"),
        options: ["de", "en", "pl"]
    )
}
