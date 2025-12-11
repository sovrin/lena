//
//  WindowHiddenToolbarView.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//
import SwiftUI

struct WindowHiddenToolbarView<Content: View>: NSViewRepresentable {

    init(
        contentTopPadding: Binding<CGFloat>,
        content: @escaping () -> Content
    ) {
        _contentTopPadding = contentTopPadding
        self.content = content
    }

    @Binding private var contentTopPadding: CGFloat
    private let content: () -> Content

    func makeNSView(context: Context) -> some NSView {
        let view = NSHostingViewIgnoringSafeArea(
            rootView: content()
        )

        DispatchQueue.main.async {
            if let window = view.window {
                let windowFrameHeight = window.frame.height
                let contentLayoutFrameHeight = window.contentLayoutRect.height
                let titlebarHeight =
                    windowFrameHeight - contentLayoutFrameHeight
                contentTopPadding = -titlebarHeight

                // we need to make sure to set alpha back to 1, since we are setting
                // it to 0 in NSHostingViewSuppressingSafeArea
                window.alphaValue = 1
            }
        }

        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }

}
