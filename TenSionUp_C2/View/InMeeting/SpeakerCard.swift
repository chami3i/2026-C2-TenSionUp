//
//  SpeakerCard.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//

import SwiftUI

struct SpeakerCard: View {
    let speaker: Speaker
    let timerSeconds: Int
    
    private var showTimer: String {
        let minutes = timerSeconds / 60
        let seconds = timerSeconds % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    var body: some View {
        VStack {
            // Name
            Text(speaker.name)
                .font(.title3)
                .bold()
            
            // Image
            Text(speaker.image)
                .font(.title)
            
            // Timer
            Text(showTimer)
            
            // Progress Bar
//            ProgressView()
        }
        .frame(width: 180, height: 250)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(20)
    }
}

#Preview {
    SpeakerCard(speaker: Speaker(name: "BARA", image: "🐰", time: 180), timerSeconds: 180)
}
