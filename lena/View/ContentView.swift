//
//  ContentView.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = TranslationSearchViewModel()

    var body: some View {
        VStack {
            SearchBar(
                query: $vm.query,
                sourceLanguage: $vm.sourceLanguage,
                targetLanguage: $vm.targetLanguage,
                isLoading: vm.isLoading
            )

            SearchResult(
                errorMessage: vm.errorMessage,
                results: vm.results
            )
        }
        .padding()
        .onChange(of: vm.query) { _, newValue in
            vm.scheduleDebouncedSearch(newValue)
        }
    }
}

#Preview {
    ContentView()
}

