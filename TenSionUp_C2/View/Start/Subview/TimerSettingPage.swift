//
//  TimerSettingPage.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//
import SwiftUI

struct TimerSettingPage: View {
    @Binding var timerSeconds: Int
    @Binding var minute: Int
    @Binding var second: Int
    @Binding var currentPage: Int
    let startMeeting: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("1인당 발화 시간은 얼마인가요?")
                .font(.title2)
            
            Text("한 사람당 말할 수 있는 시간을 설정해주세요")
                .foregroundColor(Color.gray)
            
            // 타이머
            HStack {
                Picker("분", selection: $minute) {
                    ForEach(0..<21) { minute in
                        Text("\(minute)분")
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: minute) { _, _ in
                    timerSeconds = minute * 60 + second
                }
                
                Picker("초", selection: $second) {
                    ForEach([0, 10, 20, 30, 40, 50], id: \.self) { second in
                        Text("\(second)초")
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: second) { _, _ in
                    timerSeconds = minute * 60 + second
                }
            }
            
            // Button
            Button {
                timerSeconds = minute * 60 + second
                startMeeting()
            } label: {
                Label("다음", systemImage: "arrow.right")
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TimerSettingPage(timerSeconds: .constant(180), minute: .constant(3), second: .constant(0), currentPage: .constant(2), startMeeting: {})
}
