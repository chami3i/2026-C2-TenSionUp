//
//  AddSpeakerC.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//
import SwiftUI

struct AddSpeakerCard: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .font(.title)
                
                Text("참가자 추가")
                    .font(.title3)
            }
            .foregroundStyle(isEnabled ? Color.gray : Color.gray.opacity(0.35))
            .frame(width: 180, height: 180)
            .background(isEnabled ? Color.gray.opacity(0.15) : Color.gray.opacity(0.08))
            .cornerRadius(20)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .disabled(!isEnabled)
        .allowsHitTesting(isEnabled)
    }
}

#Preview {
    AddSpeakerCard(isEnabled: true) {
        print("Tapped")
    }
}
