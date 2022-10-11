//
//  ColorButtonsView.swift
//  HueKnows Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import SwiftUI

struct ColorButtonsView: View {
  private let correctColorType: ColorType
  private let randomIndex: Int
  private let colorTypes: [ColorType]
  let onButtonPressed: (_ wasCorrect: Bool) -> ()
  
  init(onButtonPressed: @escaping (_ wasCorrect: Bool) -> Void) {
    let randomColorTypes = ColorType.allCases.shuffled()
    
    colorTypes = Array(randomColorTypes[...3])
    correctColorType = randomColorTypes.last!
    randomIndex = Int.random(in: 0...3)
    
    self.onButtonPressed = onButtonPressed
  }
  
  var body: some View {
    VStack(spacing: 10) {
      HStack(spacing: 10) {
        buttonWithText(for: 0)
        buttonWithText(for: 1)
      }
      
      HStack(spacing: 10) {
        buttonWithText(for: 2)
        buttonWithText(for: 3)
      }
    }
  }
  
  private func buttonWithText(for index: Int) -> some View {
    let correctAnswer = index == randomIndex
    
    return Button {
      onButtonPressed(correctAnswer)
    } label: {
      Text(colorTypes[index].rawValue)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
          (correctAnswer ? correctColorType : colorTypes[index]).color.gradient
        )
        .cornerRadius(20)
    }
    .buttonStyle(.plain)
  }
}

struct ColorButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    ColorButtonsView(onButtonPressed: { _ in })
  }
}
