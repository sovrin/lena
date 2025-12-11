//
//  Keyboardshortcuts.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import KeyboardShortcuts
import AppKit

extension KeyboardShortcuts.Name {
    static let openHotkeyWindow = Self("openHotkeyWindow", default: .init(.l, modifiers: [.shift, .command]))
    static let closeHotkeyWindow = Self("closeHotkeyWindow", default: .init(.escape))
}
