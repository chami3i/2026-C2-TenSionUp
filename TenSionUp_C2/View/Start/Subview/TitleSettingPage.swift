//
//  TitleSettingPage.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//
import SwiftUI

struct TitleSettingPage: View {
    @Binding var step: Step
    @Binding var title: String
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("어떤 회의인가요?")
                .font(.title2)
            
            Text("회의 이름을 입력해주세요.")
                .foregroundColor(Color.gray)
            
            // TextField
            TextField("회의 이름을 입력해주세요.", text: $title)
                .textFieldStyle(.roundedBorder)
            
            // Button
            Button {
                step = .speakers
                currentPage = 1
            } label: {
                Label("다음", systemImage: "arrow.right")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
            }
            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .foregroundStyle(
                title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                ? Color.gray.opacity(0.55)
                : Color.black
            )
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        ? Color.gray.opacity(0.08)
                        : Color.gray.opacity(0.15)
                    )
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TitleSettingPage(step: .constant(.title), title: .constant("텐션업"), currentPage: .constant(0))
}
