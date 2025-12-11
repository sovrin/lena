//
//  Response.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import Foundation

struct TranslationResult: Codable, Identifiable, Hashable {
    var id: String {
        "\(sourceTranslation.text)|\(targetTranslation.text)"
    }

    let sourceTranslation: Translation
    let targetTranslation: Translation
    let targetTranslationAudioUrl: URL?
}

struct Translation: Codable, Hashable {
    let text: String
    let meta: TranslationMeta
}

struct TranslationMeta: Codable, Hashable {
    let abbreviations: [String]
    let comments: [String]
    let optionalData: [String]
    let wordClassDefinitions: [String]
}

typealias TranslationResponse = [TranslationResult]
