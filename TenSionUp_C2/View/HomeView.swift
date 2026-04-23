//
//  HomeView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/23/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appNavigation: AppNavigation
    
    var body: some View {
        VStack(spacing: 36) {
            Spacer()
            
            VStack(spacing: 10) {
                Text("TenSionUp")
                    .font(.largeTitle)
                    .bold()
                
                Text("오늘의 회의를 시작해보세요.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 0) {
                HomeMenuButton(
                    title: "회의 시작하기",
                    systemImage: "person.2.fill",
                    tint: .gray,
                    action: appNavigation.openStart
                )
                
                Divider()
                    .frame(height: 64)
                
                HomeMenuButton(
                    title: "회의록 보기",
                    systemImage: "list.bullet",
                    tint: .gray,
                    action: appNavigation.openMinutes
                )
            }
            .frame(maxWidth: 340)
            .padding(.vertical, 14)
//            .overlay{
//                RoundedRectangle(cornerRadius: 0)
//                    .stroke(Color.gray, lineWidth: 1)
//            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

private struct HomeMenuButton: View {
    let title: String
    let systemImage: String
    let tint: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 28, weight: .semibold))
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(tint)
            .frame(maxWidth: .infinity)
            .frame(height: 74)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppNavigation())
}
