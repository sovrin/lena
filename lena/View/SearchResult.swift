//
//  Untitled.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchResult: View {
    let errorMessage: String?
    let results: [TranslationResult]

    var body: some View {
        if let msg = errorMessage {
            Text(msg).foregroundStyle(.red).padding(.horizontal)
        }

        VStack {
            List(results) { item in
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.sourceTranslation.text)
                        .font(.headline)

                    Text(item.targetTranslation.text)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }

            .listStyle(.plain)
        }
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SearchResult(
        errorMessage: nil,
        results: [
            TranslationResult(
                sourceTranslation: Translation(
                    text: "Hallo",
                    meta: TranslationMeta(
                        abbreviations: [],
                        comments: [],
                        optionalData: [],
                        wordClassDefinitions: []
                    )
                ),
                targetTranslation: Translation(
                    text: "Hello",
                    meta: TranslationMeta(
                        abbreviations: [],
                        comments: [],
                        optionalData: [],
                        wordClassDefinitions: []
                    )
                ),
                targetTranslationAudioUrl: nil
            )
        ]
    )
}
