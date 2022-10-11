//
//  GameOverSheet.swift
//  HueKnows Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import SwiftUI

struct GameOverSheet: View {
  private let secondsToFinish: Int
  let onPlayAgainPressed: () -> Void
  
  init(
    startTime: Date,
    onPlayAgainPressed: @escaping () -> Void
  ) {
    secondsToFinish = Int(Date.now.timeIntervalSince(startTime))
    self.onPlayAgainPressed = onPlayAgainPressed
  }
  
  var body: some View {
    VStack {
      Text("You win!")
        .font(.largeTitle)
      Text("You finished in \(secondsToFinish) seconds.")
      Button("Play Again", action: onPlayAgainPressed)
    }
  }
}

struct GameOverSheet_Previews: PreviewProvider {
  static var previews: some View {
    GameOverSheet(startTime: .now, onPlayAgainPressed: {})
  }
}
