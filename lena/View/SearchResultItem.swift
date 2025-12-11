//
//  SearchResultItem.swift
//  lena
//
//  Created by sovrin on 12.12.25.
//

import AVFoundation
import SwiftUI

struct SearchResultItem: View {
    var item: TranslationResult

    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false
    @State private var playerObserver: Any?

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(item.sourceTranslation.text)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(3)
                        .multilineTextAlignment(.trailing)

                    if let url = item.targetTranslationAudioUrl {
                        Button {
                            togglePlayback(url: url)
                        } label: {
                            Image(
                                systemName: isPlaying
                                    ? "stop.fill" : "speaker.wave.2"
                            )
                            .font(.caption)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .padding(2)
                            .contentShape(Rectangle())
                            .background(.thinMaterial.opacity(0.0001))
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 6,
                                    style: .continuous
                                )
                            )
                            .help(
                                isPlaying ? "Stop audio" : "Play pronunciation"
                            )
                        }
                        .buttonStyle(.plain)
                        .keyboardShortcut(.space, modifiers: [])  // optional
                    } else {
                        EmptyView()
                    }
                }

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
                HStack(spacing: 8) {
                    Text(item.targetTranslation.text)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(3)
                        .multilineTextAlignment(.trailing)
                }

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
        .padding(8)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 8))
        .padding(.vertical, 2)
        .contentShape(Rectangle())
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .onDisappear {
            stopPlayback()
        }
    }

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

    private func togglePlayback(url: URL) {
        if isPlaying {
            stopPlayback()
        } else {
            startPlayback(url: url)
        }
    }

    private func startPlayback(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: playerItem)
        player = newPlayer

        // Observe end of playback to reset UI state
        playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak playerItem] _ in
            if playerItem === self.player?.currentItem {
                stopPlayback()
            }
        }

        newPlayer.play()
        isPlaying = true
    }

    private func stopPlayback() {
        player?.pause()
        player = nil
        isPlaying = false

        if let obs = playerObserver {
            NotificationCenter.default.removeObserver(obs)
            playerObserver = nil
        }
    }
}

#Preview {
    SearchResultItem(
        item: TranslationResult(
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
            targetTranslationAudioUrl: URL(
                string: "https://example.com/audio.mp3"
            )
        )
    )
}
