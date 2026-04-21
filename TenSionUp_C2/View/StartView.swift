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
            MeetingNamePage()
                .tag(0)
            
            SpeakerInfoPage()
                .tag(1)
                
            TimerSettingPage()
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
    
    @ViewBuilder
    func MeetingNamePage() -> some View {
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
        }
    }
    
    @ViewBuilder
    func SpeakerInfoPage() -> some View {
        VStack {
            Text("누가 참여하나요?")
                .font(.title2)
            
            Text("이름과 이미지를 설정해주세요.")
                .foregroundColor(Color.gray)
            
            // 참여자 입력 카드
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            let displayedSpeakers: [Speaker] = [
                Speaker(name: "CHAEM", image: "🐶", time: timerSeconds)
            ] + speakers
            
            //TODO: spacing alignment
            LazyVGrid(columns: columns) {
                ForEach(0..<4, id: \.self) { index in
                    if index < displayedSpeakers.count {
                        let speaker = displayedSpeakers[index]
                        
                        VStack {
                            Text(speaker.name)
                                .font(.title2)
                                .bold()
                            
                            Text(speaker.image)
                                .font(.system(size: 100))
                        }
//                        .frame(maxWidth: .infinity)
                        .frame(width: 180, height: 180)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(20)
                        
                    } else {
                        if index == displayedSpeakers.count {
                            AddSpeakerCard(isEnabled: true) {
                                nextSlotIndex = index
                                newSpeakerName = ""
                                newSpeakerImage = ""
                                showAddSpeakerSheet = true
                            }
                        } else {
                            AddSpeakerCard(isEnabled: false) {
                            }
                        }
                    }
                     
                }
            }
            .sheet(isPresented: $showAddSpeakerSheet) {
                VStack {
                    HStack { //TODO: trailing alignment
                        Button {
                            showAddSpeakerSheet = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color.gray)
                        }
                    }
                   
                    Text("참가자 추가")
                        .font(.title)
                    
                    Text(newSpeakerImage)
                        .font(.system(size: 60))
                        .foregroundStyle(Color.gray)
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("이름")
                        
                        TextField("이름을 입력하세요", text: $newSpeakerName)
                            .padding(.bottom, 16)
                        
                        Text("이미지 선택")
                        
                        HStack {
                            ForEach(["🐰", "🦁", "🦊", "👽", "🐱"], id: \.self) { image in
                                Button {
                                    newSpeakerImage = image
                                } label: {
                                    Text(image)
                                        .font(.title)
                                }
                                .foregroundStyle(Color.gray)
                                .frame(width: 55, height: 55)
                                .background(newSpeakerImage == image ?
                                            Color.gray.opacity(0.3) : Color.gray.opacity(0.15))
                                .cornerRadius(15)
                                
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title3)
                            }
                            .foregroundStyle(Color.gray)
                            .frame(width: 55, height: 55)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(15)
                        }
                        
                        Button {
                            let trimmedName = newSpeakerName.trimmingCharacters(in: .whitespacesAndNewlines)
                             
                             guard !trimmedName.isEmpty else { return }
                             guard !newSpeakerImage.isEmpty else { return }
                             
                             speakers.append(
                                 Speaker(
                                     name: trimmedName,
                                     image: newSpeakerImage,
                                     time: timerSeconds
                                 )
                             )
                             newSpeakerName = ""
                             newSpeakerImage = ""
                             showAddSpeakerSheet = false
                        } label: {
                            Text("추가하기")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .padding(16)
                    
                }
            }
            
            // Button
            Button {
                currentPage = 2
            } label: {
                Label("다음", systemImage: "arrow.right")
            }
            .disabled(([Speaker(name: "CHAEM", image: "🐶", time: timerSeconds)] + speakers).count < 2)
        }
    }
    
    @ViewBuilder
    func AddSpeakerCard(isEnabled: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .font(.title)
                
                Text("참가자 추가")
                    .font(.title3)
            }
            .foregroundStyle(isEnabled ? Color.gray : Color.gray.opacity(0.35))
            .frame(width: 180, height: 180)
            .background(isEnabled ? Color.gray.opacity(0.15) : Color.gray.opacity(0.08))
            .cornerRadius(20)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .disabled(!isEnabled)
        .allowsHitTesting(isEnabled)
    }
    
    @ViewBuilder
    func TimerSettingPage() -> some View {
        VStack {
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
                
                Picker("초", selection: $second) {
                    ForEach([0, 10, 20, 30, 40, 50], id: \.self) { second in
                        Text("\(second)초")
                    }
                }
                .pickerStyle(.wheel)
            }
            
            // Button
            Button {
                
            } label: {
                Label("다음", systemImage: "arrow.right")
            }
        }
    }

}

#Preview {
    StartView()
}
