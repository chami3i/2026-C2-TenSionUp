//
//  MinutesView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/22/26.
//

import SwiftUI
import SwiftData

struct MinutesView: View {
    @Query(sort: \Meeting.createdAt, order: .reverse) private var meetings: [Meeting]
    
    private let mainSpeakerName = "CHAEM"
    
    private var totalMeetingCount: Int {
        meetings.filter { !$0.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }.count
    }
    
    private var totalListeningSeconds: Int {
        meetings.reduce(0) { total, meeting in
            total + (meeting.speakers.first { $0.name == mainSpeakerName }?.listeningSeconds ?? 0)
        }
    }
    var body: some View {
        VStack{
            Text("회의록 보기")
            
            Text("지난 회의를 확인해보세요.")
            
            HStack {
                VStack {
                    Text("\(totalMeetingCount)")// 총 회의 수
                    
                    Text("총 회의")
                }
                .frame(width: 120, height: 90)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(20)
                
                VStack {
                    Text(formatListeningTime(totalListeningSeconds)) // 총 경청 시간
                    
                    Text("총 경청 시간")
                }
                .frame(width: 120, height: 90)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(20)
                
                VStack {
                    Text("8") // 완료한 Self Review
                    
                    Text("Self Review")
                }
                .frame(width: 120, height: 90)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(20)
            }
            
            Text("지난 회의")
            
            
        }
    }
    
    private func formatListeningTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        return "\(minutes)분 \(remainingSeconds)초"
    }
}

#Preview {
    MinutesView()
        .modelContainer(for:Meeting.self, inMemory: true)
}
