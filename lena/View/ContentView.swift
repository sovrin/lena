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
            SearchBar()
                .environmentObject(vm)

            SearchResult()
                .environmentObject(vm)
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
