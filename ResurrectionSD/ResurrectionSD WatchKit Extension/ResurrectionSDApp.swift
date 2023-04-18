//
//  ResurrectionSDApp.swift
//  ResurrectionSD WatchKit Extension
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI

@main
struct ResurrectionSDApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
