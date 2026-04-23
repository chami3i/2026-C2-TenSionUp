//
//  ResultView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/22/26.
//

import SwiftUI
import Charts

struct ResultView: View {
    let meeting: Meeting
    let checklistItems: [String] = [
        "혼자서 대화를 독점하지 않는다.",
        "말하는 이와 시선을 맞춘다. (eye-contact)",
        "듣는 척 하지 않고 집중해서 경청한다."
    ]
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var appNavigation: AppNavigation
    
    private var speakers: [Speaker] {
        meeting.speakers
    }
    
    var body: some View {
        VStack {
            Divider()
            
            Text(meeting.title)
                .fontWeight(.light)
            
            Divider()
            
            Text("수고하셨습니다!")
                .font(Font.title3)
                .bold()
                .padding(.top, 30)
            
            Text("오늘의 BEST 경청 PICK !")
                .font(Font.title3)
                .bold()
                .padding(20)
            
            HStack {
                VStack {
                    ForEach(speakers) { speaker in
                        Text(speaker.image)
                            .font(.system(size: 45))
                            .frame(width: 55, height: 55)
                            .padding(.vertical, 10)
                    }
                }
                
                Chart {
                    ForEach(speakers) { data in
                        BarMark(
                            x: .value("시간", data.listeningSeconds),
                            y: .value("사람", data.name)
                        )
                        .annotation(position: .trailing) {
                            Text(formatTime(data.listeningSeconds))
                                .font(.caption)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            if let seconds = value.as(Int.self) {
                                Text(formatTime(seconds))
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 16)
            
            Text("오늘의 경청 CHECKLIST !")
                .font(Font.title3)
                .bold()
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(checklistItems, id: \.self) { item in
                    HStack {
                        CheckboxButton()
                        
                        Text(item)
                            .font(.custom("ChosunGs", size: 15))
                            .foregroundStyle(Color.black)
                    }
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Button {
                appNavigation.goHome()
            } label: {
                Text("홈으로 나가기")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.blue.opacity(0.70))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func formatTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

#Preview {
    ResultView(
        meeting: Meeting(
            title: "텐션업 텐션 올리기 대책 회의",
            speakers: [
                Speaker(name: "CHAEM", image: "🐶", time: 180, speakingSeconds: 120, listeningSeconds: 70),
                Speaker(name: "BARA", image: "🐰", time: 180, speakingSeconds: 120, listeningSeconds: 100),
                Speaker(name: "MOO", image: "🤖", time: 180, speakingSeconds: 120, listeningSeconds: 50),
                Speaker(name: "SOONG", image: "🙊", time: 180, speakingSeconds: 120, listeningSeconds: 10)
            ],
            timerSeconds: 180
        )
    )
    .environmentObject(AppNavigation())
}
