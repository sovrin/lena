//
//  lenaApp.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

@main
struct lenaApp: App {
    private let floatingPanelHandler = FloatingPanelHandler()
    
    var body: some Scene {
        Settings {
            SettingsScreen()
        }
    }
}
