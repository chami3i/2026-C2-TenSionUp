//
//  InMeetingView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//

import SwiftUI
import SwiftData

struct InMeetingView: View {
    let meeting: Meeting
    @State private var speakers: [Speaker]
    @State private var showResultView = false
    
    @State private var timer: Timer? = nil
    @Environment(\.modelContext) private var modelContext
    
    init(meeting: Meeting) {
        self.meeting = meeting
        self._speakers = State(initialValue: meeting.speakers)
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Divider()
            
            Text(meeting.title)
                .font(.title2)
                .bold()
            
            Divider()
            
            Text("말할 사람을 선택해주세요.")
            
            LazyVGrid(columns: columns) {
                ForEach(speakers) { speaker in
                    SpeakerCard(
                        speaker: speaker,
                        onTap: { cardTap(for: speaker.id) }
                    )
                }
            }
            
            Button {
                finishMeeting()
            } label: {
                Text("회의 끝내기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
            }
            .foregroundStyle(Color.black)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.gray.opacity(0.15))
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showResultView) {
            ResultView(meeting: meeting)
        }
    }
    
    private func cardTap(for speakerID: UUID) {
        guard let index = speakers.firstIndex(where: { $0.id == speakerID }) else { return }
        
        switch speakers[index].timeState {
        case .notStarted, .paused:
            startTimer(for: speakerID)
        case .running:
            pauseTimer(for: speakerID)
        case .ended:
            break
        }
    }

    func startTimer(for speakerID: UUID) {
        stopTimer()
        
        for index in speakers.indices {
            if speakers[index].id == speakerID {
                speakers[index].timeState = .running
            } else if speakers[index].timeState == .running {
                speakers[index].timeState = .paused
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            tick(for: speakerID)
        }
    }

    func pauseTimer(for speakerID: UUID) {
        stopTimer()
        
        if let index = speakers.firstIndex(where: { $0.id == speakerID }),
           speakers[index].timeState == .running {
            speakers[index].timeState = .paused
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func tick(for speakerID: UUID) {
        guard let activeIndex = speakers.firstIndex(where: { $0.id == speakerID}) else {
            stopTimer()
            return
        }
        
        guard speakers[activeIndex].time > 0 else {
            speakers[activeIndex].timeState = .ended
            stopTimer()
            return
        }
        
        speakers[activeIndex].time -= 1
        
        for index in speakers.indices {
            if speakers[index].id == speakerID {
                speakers[index].speakingSeconds += 1
            } else {
                speakers[index].listeningSeconds += 1
            }
        }
        
        if speakers[activeIndex].time == 0 {
            speakers[activeIndex].timeState = .ended
            stopTimer()
        }
    }
    
    private func finishMeeting() {
        stopTimer()
        
        for index in speakers.indices where speakers[index].timeState == .running {
            speakers[index].timeState = .paused
        }
        
        meeting.speakers = speakers
        meeting.endedAt = Date()
        try? modelContext.save()
        showResultView = true
    }
}

#Preview {
    InMeetingView(
        meeting: Meeting(
            title: "텐션업",
            speakers: [
                Speaker(name: "CHAEM", image: "🐶", time: 180),
                Speaker(name: "BARA", image: "🐰", time: 180),
                Speaker(name: "MOO", image: "🤖", time: 180),
                Speaker(name: "SOONG", image: "🙊", time: 180)
            ],
            timerSeconds: 180)
        )
}
