//
//  ContentView.swift
//  HueKnows Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import SwiftUI
import UserNotifications



struct ContentView: View {
  @State private var startTime: Date = .now
  @State private var currentLevel: Int = .zero
  @State private var isGameOver = false
  @State private var title: String = .empty
  
  private let maxLevel = 10
  
  var body: some View {
    NavigationStack {
      ColorButtonsView(onButtonPressed: tapped)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: startNewGame)
        .sheet(isPresented: $isGameOver) {
          GameOverSheet(startTime: startTime) {
            startNewGame()
          }
        }
    }
  }
}

extension ContentView {
  private func startNewGame() {
    currentLevel = 1
    isGameOver = false
    startTime = .now
    
    setPlayReminder()
    createLevel()
  }
  
  private func createLevel() {
    guard currentLevel <= maxLevel else {
      isGameOver = true
      return
    }
    
    title = "Level \(currentLevel)/\(maxLevel)"
  }
  
  private func tapped(correctAnswer: Bool) {
    if correctAnswer {
      currentLevel += 1
    } else {
      if currentLevel > 1 {
        currentLevel -= 1
      }
    }
    
    createLevel()
  }
  
  private func createNotification() {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "We miss you!"
    content.body = "Come back and play the game some more."
    content.sound = .default
    content.categoryIdentifier = "play_reminder"
    
    // Time interval trigger
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    // Calendar trigger
    var components = DateComponents()
    components.hour = 24
    components.minute = 0
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
    
    let request = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: content,
      trigger: trigger
    )
    center.add(request)
  }
  
  private func setPlayReminder() {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { wasSuccessful, error in
      if wasSuccessful {
        center.removeAllPendingNotificationRequests()
        registerCategories()
        createNotification()
      }
    }
  }
  
  private func registerCategories() {
    let center = UNUserNotificationCenter.current()
    
    let play = UNNotificationAction(identifier: "play", title: "Play Now", options: .foreground)
    let category = UNNotificationCategory(identifier: "play_reminder", actions: [play], intentIdentifiers: [])
    
    center.setNotificationCategories([category])
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
