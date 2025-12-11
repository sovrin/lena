//
//  Untitled.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchResult: View {
    @EnvironmentObject var vm: TranslationSearchViewModel

    var body: some View {
        if let msg = vm.errorMessage {
            Text(msg).foregroundStyle(.red).padding(.horizontal)
        }

        List(vm.results) { item in
            VStack(alignment: .leading, spacing: 6) {
                Text(item.sourceTranslation.text)
                    .font(.headline)

                Text(item.targetTranslation.text)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SearchResult()
        .environmentObject(TranslationSearchViewModel())
}
