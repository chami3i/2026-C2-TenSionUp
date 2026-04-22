//
//  MeetingCard.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/23/26.
//

import SwiftUI
import SwiftData

struct MeetingCard: View {
    let meeting: Meeting
    
    private static let createdAtFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy. M. d E  a h:mm"
        return formatter
    }()
    
    private var meetingDurationSeconds: Int {
        guard let endedAt = meeting.endedAt else { return 0 }
        return max(0, Int(endedAt.timeIntervalSince(meeting.createdAt)))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(meeting.title)
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 22)
            .padding(.trailing, 22)
            .frame(height: 60)
            
            Divider()
                .background(Color.gray.opacity(0.30))
            
            HStack {
                Text(Self.createdAtFormatter.string(from: meeting.createdAt))
                    .font(.system(size: 16))
                
                Spacer()
                
                Label(formatDuration(meetingDurationSeconds), systemImage: "clock")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.blue)
                    .labelStyle(.titleAndIcon)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.14))
                    .clipShape(Capsule())
            }
            .padding(.leading, 22)
            .padding(.trailing, 22)
            .frame(height: 50)
        }
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle (cornerRadius: 20, style: .continuous))
        .padding(.horizontal, 16)
    }
    
    
    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        return "\(minutes)분 \(remainingSeconds)초"
    }
}

#Preview {
    MeetingCard(
        meeting: Meeting(
        title: "텐션업 텐션 올리기 대책 회의",
        createdAt: Date(),
        endedAt: Date().addingTimeInterval(160),
        speakers: [],
        timerSeconds: 180
        )
    )
    .modelContainer(for: Meeting.self, inMemory: true)
}
