//
//  ColorType.swift
//  HueKnows Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import SwiftUI

enum ColorType: String {
  case red = "Red"
  case green = "Green"
  case blue = "Blue"
  case orange = "Orange"
  case purple = "Purple"
  case black = "Black"
}

extension ColorType: CaseIterable, Identifiable {
  var id: Self { self }
  
  var color: Color {
    switch self {
    case .red:
      return Color(red: 1, green: 0, blue: 0)
    case .green:
      return Color(red: 0, green: 0.5, blue: 0)
    case .blue:
      return Color(red: 0, green: 0, blue: 1)
    case .orange:
      return Color(red: 1, green: 0.6, blue: 0)
    case .purple:
      return Color(red: 0.5, green: 0, blue: 0.5)
    case .black:
      return .black
    }
  }
  
  static var all: [ColorType] {
    ColorType.allCases.filter { $0 != .black }
  }
  
  static var random: ColorType {
    ColorType.all.randomElement() ?? .red
  }
}
