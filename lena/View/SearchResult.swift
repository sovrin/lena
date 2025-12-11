//
//  Untitled.swift
//  lena
//
//  Created by sovrin on 11.12.25.
//

import SwiftUI

struct SearchResult: View {

    var body: some View {
        HStack(spacing: 16) {
            Menu {
                Button("Button 1", action: test)
                Button(
                    "Button 2",
                    systemImage: "button.vertical.left.press",
                    action: test
                )
                Button(action: test) {
                    Text("Button 3")
                    Text("Description 3")
                }
            } label: {
                Text("Button 0")
            } primaryAction: {
                print("Button 0 tapped")
            }
        }
        .padding()
        .glassEffect(.regular.interactive())
    }

    func test() {

    }

}

#Preview {
    SearchResult()

}
