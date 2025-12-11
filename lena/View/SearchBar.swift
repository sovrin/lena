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
                    .frame(width: 24, height: 24)
            }

            TextField("Translate", text: $vm.query)
                .font(.title)
                .textFieldStyle(.plain)
                .focused($focused)

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
