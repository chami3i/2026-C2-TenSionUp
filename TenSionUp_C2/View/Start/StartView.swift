//
//  StartView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/20/26.
//

import SwiftUI
import SwiftData

enum Step {
    case meetingName
    case speakers
    case timer
}

struct StartView: View {
    @State private var step: Step = .meetingName
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var currentPage = 0
    @State private var meetingName: String = ""
    @State private var speakers: [Speaker] = []
    @State private var timerSeconds: Int = 180
    
    @State private var showAddSpeakerSheet: Bool = false
    @State private var newSpeakerName: String = ""
    @State private var newSpeakerImage: String = ""
    @State private var nextSlotIndex: Int? = nil
    
    @State private var minute: Int = 3
    @State private var second: Int = 0
    
    @State private var startMeeting = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("새 회의")
                    .font(.largeTitle)
                    .bold()
                
                // Page Control
                HStack(spacing: 8) {
                    Circle()
                        .fill(currentPage >= 0 ? Color.gray : Color.gray.opacity(0.2))
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(currentPage >= 1 ? Color.gray : Color.gray.opacity(0.2))
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(currentPage >= 2 ? Color.gray : Color.gray.opacity(0.2))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 16)
                
                switch step {
                case .meetingName:
                    MeetingNamePage(
                        step: $step,
                        meetingName: $meetingName,
                        currentPage: $currentPage
                    )
                case .speakers:
                    SpeakerInfoPage(
                        step: $step,
                        speakers: $speakers,
                        timerSeconds: $timerSeconds,
                        showAddSpeakerSheet: $showAddSpeakerSheet,
                        newSpeakerName: $newSpeakerName,
                        newSpeakerImage: $newSpeakerImage,
                        nextSlotIndex: $nextSlotIndex,
                        currentPage: $currentPage
                    )
                case .timer:
                    TimerSettingPage(
                        timerSeconds: $timerSeconds,
                        minute: $minute,
                        second: $second,
                        currentPage: $currentPage,
                        startMeeting: $startMeeting
                    )
                }
            }
            .navigationDestination(isPresented: $startMeeting) {
                InMeetingView(meetingName: meetingName,
                speakers: [Speaker(name: "CHAEM", image: "🐶", time: timerSeconds)] + speakers,
                timerSeconds: timerSeconds
                )
            }
        }
    }
}

#Preview {
    StartView()
}
