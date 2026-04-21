//
//  TenSionUp_C2App.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/20/26.
//

import SwiftUI
import SwiftData

@main
struct TenSionUp_C2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Meeting.self)
    }
}
