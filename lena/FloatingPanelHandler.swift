//
//  FloatingPanelHandler.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI
import KeyboardShortcuts

final class FloatingPanelHandler {
    
    private var panel: NSPanel?
    
    init() {
        KeyboardShortcuts.onKeyUp(for: .openHotkeyWindow) {
            if self.panel == nil {
                self.open()
            } else {
                self.close()
            }
        }
        
        KeyboardShortcuts.onKeyUp(for: .closeHotkeyWindow) {
            self.close()
        }
    }
    
    func open() {
        guard panel == nil else { return }
        
        let panel = FloatingPanel(
            view: {
                HotkeyView()
            },
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: 750,
                height: 0
            ),
            didClose: { [weak self] in
                // when `didClose` gets called, make sure to remove the reference
                // to allow it to deallocate
                self?.panel = nil
            }
        )
        
        // it's important to activate the NSApplication so that the window shows on top and takes the focus
        NSApplication.shared.activate()
        panel.makeKeyAndOrderFront(nil)
        panel.orderFrontRegardless()
        panel.center()
        
        self.panel = panel
    }
    
    func close() {
        guard let panel = panel else { return }
        panel.close()
        self.panel = nil
    }
}
