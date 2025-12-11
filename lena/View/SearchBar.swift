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

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)

                CompactCodePicker(
                    selection: $targetLanguage,
                    options: targetOptions
                )
            }
        }
        .onAppear { focused = true }
        .padding()
        .glassEffect(.regular.interactive())
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

