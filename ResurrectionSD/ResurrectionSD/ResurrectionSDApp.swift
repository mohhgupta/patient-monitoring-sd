//
//  ResurrectionSDApp.swift
//  ResurrectionSD
//
//  Created by Mohh Gupta on 4/5/21.
//

import SwiftUI

@main
struct ResurrectionSDApp: App {
    @StateObject var model = ViewModelPhone()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
