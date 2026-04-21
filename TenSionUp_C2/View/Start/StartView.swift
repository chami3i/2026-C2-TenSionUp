//
//  StartView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/20/26.
//

import SwiftUI
import SwiftData

struct StartView: View {
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
    
    var body: some View {
        VStack {
            Text("새 회의")
                .font(.largeTitle)
                .bold()
            
            // Page Control
            
            TabView(selection: $currentPage) {
            MeetingNamePage(
                meetingName: $meetingName,
                currentPage: $currentPage
            )
                .tag(0)
            
            SpeakerInfoPage(
                speakers: $speakers,
                timerSeconds: $timerSeconds,
                showAddSpeakerSheet: $showAddSpeakerSheet,
                newSpeakerName: $newSpeakerName,
                newSpeakerImage: $newSpeakerImage,
                nextSlotIndex: $nextSlotIndex,
                currentPage: $currentPage
            )
                .tag(1)
                
            TimerSettingPage(
                timerSeconds: $timerSeconds,
                minute: $minute,
                second: $second,
                currentPage: $currentPage
            )
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
//            .sheet(isPresented: $showAddSpeakerSheet, onDismiss: {
//                                currentPage = 1
//            }) {
//                AddSpeakerInfoSheet(
//                    showAddSpeakerSheet: $showAddSpeakerSheet,
//                    speakers: $speakers,
//                    timerSeconds: $timerSeconds,
//                    newSpeakerName: $newSpeakerName,
//                    newSpeakerImage: $newSpeakerImage
//                )
//            }
        }
    }
}

#Preview {
    StartView()
}
