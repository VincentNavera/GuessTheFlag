//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Vincio on 7/6/21.
//

import SwiftUI

struct FlagImage: ViewModifier {

    func body(content: Content) -> some View {
        content
            .clipShape(Capsule()).overlay(Capsule().stroke(Color .black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }

}

extension View {
    func flagImage() -> some View {
        self.modifier(FlagImage())
    }
}


