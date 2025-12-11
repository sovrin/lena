//
//  FloatingPanel.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI
import QuartzCore

final class FloatingPanel<Content: View>: NSPanel {

    init(
        view: () -> Content,
        contentRect: NSRect,
        didClose: @escaping () -> Void
    ) {
        self.didClose = didClose

        super.init(
            contentRect: .zero,
            styleMask: [
                .borderless,
                .nonactivatingPanel,
                .titled,
                .fullSizeContentView,
            ],
            backing: .buffered,
            defer: false
        )

        // allow the panel to be on top of other windows
        isFloatingPanel = true
        level = .statusBar

        // allow the panel to be overlaod in a fullscreen space
        collectionBehavior = [
            .canJoinAllSpaces, .fullScreenAuxiliary, .transient, .ignoresCycle,
        ]

        // don't show a window title, even if it's set
        titleVisibility = .hidden
        titlebarAppearsTransparent = true

        // since there is not title bar, make the window movable by dragging on the background
        isMovableByWindowBackground = true

        // hide when unfocused
        hidesOnDeactivate = true

        // hide all traffic light buttons
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true

        // set animations accordingly
        animationBehavior = .utilityWindow

        // enable frost UI effect
        backgroundColor = .clear
        isOpaque = false
        hasShadow = false

        // set the contentview
        // the safe area is ignored because the title bar still interfereswith the geometry
        contentView = NSHostingViewIgnoringSafeArea(
            rootView: view()
        )
    }

    private let didClose: () -> Void

    // close automatically when out of focus
    override func resignKey() {
        super.resignKey()
        close()
    }

    // close and toggle presentation, so that it matches the current state of the panel
    override func close() {
        super.close()
        didClose()
    }

    // Let Escape trigger close (standard Cocoa behavior hook)
    override func cancelOperation(_ sender: Any?) {
        close()
    }

    // is required so that text inputs inside the panel can receive focus
    override var canBecomeKey: Bool {
        return true
    }

    // we don't want the window to become main and thus steal the focus from
    // the oreviously opened app completely
    override var canBecomeMain: Bool {
        return false
    }
    
    // Animate the panel appearance with subtle fade and slide up
    func animateIn() {
        // Set initial state - start slightly lower and transparent
        alphaValue = 0
        let originalFrame = frame
        
        // Slide up a few pixels (subtle movement)
        let slideOffset: CGFloat = 8
        let initialFrame = NSRect(
            x: originalFrame.origin.x,
            y: originalFrame.origin.y - slideOffset,
            width: originalFrame.width,
            height: originalFrame.height
        )
        setFrame(initialFrame, display: false)
        
        // Animate to final state with subtle timing
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            // Very smooth ease-out for subtle feel
            context.timingFunction = CAMediaTimingFunction(name: .easeOut)
            context.allowsImplicitAnimation = true
            
            self.animator().alphaValue = 1.0
            self.animator().setFrame(originalFrame, display: true)
        }
    }
}
