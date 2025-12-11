//
//  WindowHiddenToolbarModifier.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct WindowHiddenToolbarModifier: ViewModifier {

    @State
    private var contentTopPadding: CGFloat = 0

    func body(content: Content) -> some View {
        WindowHiddenToolbarView(
            contentTopPadding: $contentTopPadding,
            content: { content }
        )
        .toolbarVisibility(.hidden, for: .windowToolbar)
        .padding(.top, contentTopPadding)
    }
}

extension View {

    func windowToolbarHidden() -> some View {
        modifier(WindowHiddenToolbarModifier())
    }
}
