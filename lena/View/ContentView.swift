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

            if let msg = vm.errorMessage {
                Text(msg).foregroundStyle(.red).padding(.horizontal)
            }
            
            if vm.results.isEmpty {
                ContentUnavailableView
                    .search(text: vm.query)
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
        .padding()
        .onChange(of: vm.query) { _, newValue in
            vm.scheduleDebouncedSearch(newValue)
        }
    }

    func test() {

    }
}

#Preview {
    ContentView()
}
