//
//  ContentView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/20/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var appNavigation = AppNavigation()
    
    var body: some View {
        Group {
            switch appNavigation.screen {
            case .home:
                HomeView()
            case .mainTabs:
                MainTabView()
            }
        }
        .environmentObject(appNavigation)
    }
}

private struct MainTabView: View {
    @EnvironmentObject private var appNavigation: AppNavigation
    
    var body: some View {
        TabView(selection: $appNavigation.selectedTab) {
            StartView()
                .tabItem {
                    Label("회의하기", systemImage: "person.2.fill")
                }
                .tag(AppTab.start)
            
            MinutesView()
                .tabItem {
                    Label("회의록 보기", systemImage: "list.bullet")
                }
                .tag(AppTab.minutes)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Meeting.self, inMemory: true)
}
