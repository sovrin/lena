//
//  SearchBar.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var vm: TranslationSearchViewModel

    @FocusState private var focused: Bool

    private var sourceOptions: [String] {
        TranslationSearchViewModel.supportedLanguages.filter {
            $0 != vm.targetLanguage
        }
    }
    private var targetOptions: [String] {
        TranslationSearchViewModel.supportedLanguages.filter {
            $0 != vm.sourceLanguage
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            if vm.isLoading {
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

            TextField("Translate", text: $vm.query)
                .font(.title)
                .textFieldStyle(.plain)
                .focused($focused)

            Spacer(minLength: 6)

            HStack(spacing: 6) {
                CompactCodePicker(
                    selection: $vm.sourceLanguage,
                    options: sourceOptions
                )

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)

                CompactCodePicker(
                    selection: $vm.targetLanguage,
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
    SearchBar()
        .environmentObject(TranslationSearchViewModel())
}
