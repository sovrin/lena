//
//  TranslationSearchViewModel.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import Combine
import Foundation

@MainActor
final class TranslationSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [TranslationResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Language selections (source -> target)
    @Published var sourceLanguage: String = "de"
    @Published var targetLanguage: String = "en"

    // Supported languages
    static let supportedLanguages: [String] = [
        "bg","bs","cs","da","de","el","en","eo","es","fi","fr","hr","hu","is",
        "it","la","nl","no","pl","pt","ro","ru","sk","sq","sr","sv","tr"
    ]

    private var debounceTask: Task<Void, Never>?

    func scheduleDebouncedSearch(_ newValue: String) {
        debounceTask?.cancel()

        let q = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else {
            results = []
            errorMessage = nil
            return
        }

        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }
            await fetch(q)
        }
    }

    func fetch(_ q: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        // Keeping your current hardcoded path for now.
        // Later we can build from sourceLanguage-targetLanguage:
        // "http://localhost:3000/translate/\(sourceLanguage)-\(targetLanguage)"
        var components = URLComponents(
            string: "http://localhost:3000/translate/de-en"
        )!
        components.queryItems = [URLQueryItem(name: "query", value: q)]

        guard let url = components.url else {
            errorMessage = "Bad URL"
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard !Task.isCancelled else { return }

            if let http = response as? HTTPURLResponse,
                !(200...299).contains(http.statusCode)
            {
                errorMessage = "Server error: \(http.statusCode)"
                results = []
                return
            }

            let decoded = try JSONDecoder().decode(
                [TranslationResult].self,
                from: data
            )
            results = decoded
        } catch is CancellationError {
            //
        } catch {
            errorMessage = error.localizedDescription
            results = []
        }
    }
}

