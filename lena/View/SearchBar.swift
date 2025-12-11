//
//  SearchBar.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchBar: View {
    @FocusState private var focused: Bool
    @EnvironmentObject var vm: TranslationSearchViewModel

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
                    options: TranslationSearchViewModel.supportedLanguages
                )

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)

                CompactCodePicker(
                    selection: $vm.targetLanguage,
                    options: TranslationSearchViewModel.supportedLanguages
                )
            }
        }
        .onAppear { focused = true }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .glassEffect(.regular.interactive())
    }
}

#Preview {
    SearchBar()
        .environmentObject(TranslationSearchViewModel())
}
