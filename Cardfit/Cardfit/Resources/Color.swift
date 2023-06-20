//
//  Color.swift
//  Cardfit
//
//  Created by 서동운 on 6/20/23.
//

import Foundation
import SwiftUI

extension Color {
    static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue).opacity(0.8)
    }
}
