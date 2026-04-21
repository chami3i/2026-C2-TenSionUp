//
//  MeetingNamePage.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//
import SwiftUI

struct MeetingNamePage: View {
    @Binding var meetingName: String
    @Binding var currentPage: Int
    
    var body: some View {
        VStack {
            Text("어떤 회의인가요?")
                .font(.title2)
            
            Text("회의 이름을 입력해주세요.")
                .foregroundColor(Color.gray)
            
            // TextField
            TextField("회의 이름을 입력해주세요.", text: $meetingName)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            // Button
            Button {
                currentPage = 1
            } label: {
                Label("다음", systemImage: "arrow.right")
            }
            .disabled(meetingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(meetingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
        }
    }
}

#Preview {
    MeetingNamePage(meetingName: .constant("텐션업"), currentPage: .constant(0))
}
