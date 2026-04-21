//
//  InMeetingView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//

import SwiftUI

struct InMeetingView: View {
    let meetingName: String
    let speakers: [Speaker]
    let timerSeconds: Int
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Divider()
            
            Text(meetingName)
                .font(.title2)
                .bold()
            
            Divider()
            
            Text("말할 사람을 선택해주세요.")
            
            LazyVGrid(columns: columns) {
                ForEach(speakers, id: \.self) { speaker in
                    SpeakerCard(
                        speaker: speaker,
                        timerSeconds: timerSeconds
                    )
                }
            }
            
        }
    }
}

#Preview {
    InMeetingView(meetingName: "텐션업",
                  speakers: [
                              Speaker(name: "CHAEM", image: "🐶", time: 180),
                              Speaker(name: "BARA", image: "🐰", time: 180),
                              Speaker(name: "MOO", image: "🤖", time: 180),
                              Speaker(name: "SOONG", image: "🙊", time: 180)
                          ],
                  timerSeconds: 180)
}
