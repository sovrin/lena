//
//  NSHostingViewSuppressingSafeArea.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

final class NSHostingViewIgnoringSafeArea<T: View>: NSHostingView<T> {
    required init(rootView: T) {
        super.init(rootView: rootView)

        addLayoutGuide(layoutGuide)

        // pinning the view to the edges
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
        ])
    }

    private lazy var layoutGuide: NSLayoutGuide = NSLayoutGuide()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var safeAreaRect: NSRect { frame }

    override var safeAreaInsets: NSEdgeInsets {
        NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override var safeAreaLayoutGuide: NSLayoutGuide { layoutGuide }

    override var additionalSafeAreaInsets: NSEdgeInsets {
        get { NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        set {}
    }
}
