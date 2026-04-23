//
//  AppNavigation.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/23/26.
//

import Foundation
import Combine

enum AppScreen {
    case home
    case mainTabs
}

enum AppTab: Hashable {
    case start
    case minutes
}

final class AppNavigation: ObservableObject {
    @Published var screen: AppScreen = .home
    @Published var selectedTab: AppTab = .start
    
    func openStart() {
        selectedTab = .start
        screen = .mainTabs
    }
    
    func openMinutes() {
        selectedTab = .minutes
        screen = .mainTabs
    }
    
    func goHome() {
        screen = .home
    }
}
