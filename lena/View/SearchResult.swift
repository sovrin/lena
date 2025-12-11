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
                HStack(alignment: .firstTextBaseline, spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.sourceTranslation.text)
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)

                        if let detail = inlineMeta(
                            for: item.sourceTranslation.meta
                        ) {
                            Text(detail)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "arrow.left.and.right")
                        .font(.caption)
                        .foregroundStyle(.tertiary)

                    VStack(alignment: .trailing, spacing: 6) {
                        Text(item.targetTranslation.text)
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .lineLimit(3)
                            .multilineTextAlignment(.trailing)

                        if let detail = inlineMeta(
                            for: item.targetTranslation.meta
                        ) {
                            Text(detail)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.background.secondary)
                        .overlay {
                            RoundedRectangle(
                                cornerRadius: 14,
                                style: .continuous
                            )
                            .strokeBorder(.quaternary, lineWidth: 1)
                        }
                }
                .contentShape(Rectangle())
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }

            .listStyle(.plain)
        }
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
    }

    // Create a compact, optional inline meta summary from TranslationMeta
    private func inlineMeta(for meta: TranslationMeta) -> String? {
        var parts: [String] = []
        if let cls = meta.wordClassDefinitions.first, !cls.isEmpty {
            parts.append(cls)
        }
        if let abbr = meta.abbreviations.first, !abbr.isEmpty {
            parts.append(abbr)
        }
        if let comment = meta.comments.first, !comment.isEmpty {
            parts.append(comment)
        }
        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: " • ")
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
