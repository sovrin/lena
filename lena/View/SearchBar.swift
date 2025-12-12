//
//  SearchBar.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    @Binding var sourceLanguage: String
    @Binding var targetLanguage: String
    let isLoading: Bool

    @FocusState private var focused: Bool

    private var sourceOptions: [String] {
        TranslationSearchViewModel.supportedLanguages.filter {
            $0 != targetLanguage
        }
    }
    private var targetOptions: [String] {
        TranslationSearchViewModel.supportedLanguages.filter {
            $0 != sourceLanguage
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            if isLoading {
                ProgressView()
                    .frame(width: 24, height: 24)
                    .padding(.zero)
            } else {
                Image(systemName: "translate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.secondary)
            }

            TextField("Translate", text: $query)
                .font(.title)
                .textFieldStyle(.plain)
                .focused($focused)

            Spacer(minLength: 6)

            HStack(spacing: 6) {
                CompactCodePicker(
                    selection: $sourceLanguage,
                    options: sourceOptions
                )

                Button {
                    swapLanguages()
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .symbolRenderingMode(.hierarchical)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .contentShape(Rectangle())
                        .help("Swap languages")
                }
                .buttonStyle(.plain)
                .keyboardShortcut("s", modifiers: [.command, .shift])

                CompactCodePicker(
                    selection: $targetLanguage,
                    options: targetOptions
                )
            }
        }
        .onAppear { focused = true }
        .padding()
        .glassEffect(.regular.interactive())
        .shadow(radius: 8)
    }

    private func swapLanguages() {
        let wasFocused = focused
        let tmp = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = tmp
        if wasFocused {
            focused = true
        }
    }
}

#Preview {
    @Previewable @State var query = ""
    @Previewable @State var source = "de"
    @Previewable @State var target = "en"

    return SearchBar(
        query: $query,
        sourceLanguage: $source,
        targetLanguage: $target,
        isLoading: false
    )
}
