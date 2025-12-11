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
        VStack(spacing: 12) {
            if let msg = errorMessage {
                Text(msg)
                    .font(.callout)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }

            List(results) { item in
                SearchResultItem(item: item)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .background(Color.clear)
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
                        abbreviations: ["abbr"],
                        comments: ["colloquial"],
                        optionalData: [],
                        wordClassDefinitions: ["interj."]
                    )
                ),
                targetTranslation: Translation(
                    text: "Hello",
                    meta: TranslationMeta(
                        abbreviations: [],
                        comments: ["informal"],
                        optionalData: [],
                        wordClassDefinitions: ["interjection"]
                    )
                ),
                targetTranslationAudioUrl: nil
            ),
            TranslationResult(
                sourceTranslation: Translation(
                    text: "Haus",
                    meta: TranslationMeta(
                        abbreviations: [],
                        comments: [],
                        optionalData: [],
                        wordClassDefinitions: ["noun"]
                    )
                ),
                targetTranslation: Translation(
                    text: "House",
                    meta: TranslationMeta(
                        abbreviations: [],
                        comments: [],
                        optionalData: [],
                        wordClassDefinitions: ["noun"]
                    )
                ),
                targetTranslationAudioUrl: nil
            ),
        ]
    )
}
