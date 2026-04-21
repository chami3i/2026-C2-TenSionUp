//
//  SpeakerInfoPage.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//
import SwiftUI

struct SpeakerInfoPage: View {
    @Binding var speakers: [Speaker]
    @Binding var timerSeconds: Int
    @Binding var showAddSpeakerSheet: Bool
    @Binding var newSpeakerName: String
    @Binding var newSpeakerImage: String
    @Binding var nextSlotIndex: Int?
    @Binding var currentPage: Int
    
    var body: some View {
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
}

#Preview {
    SpeakerInfoPage(speakers: .constant([Speaker(name: "BARA", image: "🐰", time: 180)]), timerSeconds: .constant(180), showAddSpeakerSheet: .constant(false), newSpeakerName: .constant(""), newSpeakerImage: .constant("🐰"), nextSlotIndex: .constant(nil), currentPage: .constant(1))
}
