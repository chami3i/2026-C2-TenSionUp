////
////  AddSpeakerInfoSheet.swift
////  TenSionUp_C2
////
////  Created by chaem on 4/21/26.
////
//
//import SwiftUI
//
//struct AddSpeakerInfoSheet: View {
//    @Binding var showAddSpeakerSheet: Bool
//    @Binding var speakers: [Speaker]
//    @Binding var timerSeconds: Int
//    @Binding var newSpeakerName: String
//    @Binding var newSpeakerImage: String
//    
//    var body: some View {
//        VStack {
//            HStack { //TODO: trailing alignment
//                Button {
//                    showAddSpeakerSheet = false
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundStyle(Color.gray)
//                }
//            }
//            
//            Text("참가자 추가")
//                .font(.title)
//            
//            Text(newSpeakerImage)
//                .font(.system(size: 60))
//                .foregroundStyle(Color.gray)
//                .frame(width: 100, height: 100)
//                .background(Color.gray.opacity(0.15))
//                .cornerRadius(20)
//            
//            VStack(alignment: .leading, spacing: 8) {
//                Text("이름")
//                
//                TextField("이름을 입력하세요", text: $newSpeakerName)
//                    .padding(.bottom, 16)
//                
//                Text("이미지 선택")
//                
//                HStack {
//                    ForEach(["🐰", "🦁", "🦊", "👽", "🐱"], id: \.self) { image in
//                        Button {
//                            newSpeakerImage = image
//                        } label: {
//                            Text(image)
//                                .font(.title)
//                        }
//                        .foregroundStyle(Color.gray)
//                        .frame(width: 55, height: 55)
//                        .background(newSpeakerImage == image ?
//                                    Color.gray.opacity(0.3) : Color.gray.opacity(0.15))
//                        .cornerRadius(15)
//                        
//                    }
//                    
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "plus")
//                            .font(.title3)
//                    }
//                    .foregroundStyle(Color.gray)
//                    .frame(width: 55, height: 55)
//                    .background(Color.gray.opacity(0.15))
//                    .cornerRadius(15)
//                }
//                
//                Button {
//                    let trimmedName = newSpeakerName.trimmingCharacters(in: .whitespacesAndNewlines)
//                    
//                    guard !trimmedName.isEmpty else { return }
//                    guard !newSpeakerImage.isEmpty else { return }
//                    
//                    speakers.append(
//                        Speaker(
//                            name: trimmedName,
//                            image: newSpeakerImage,
//                            time: timerSeconds
//                        )
//                    )
//                    newSpeakerName = ""
//                    newSpeakerImage = ""
//                    showAddSpeakerSheet = false
//                    
//                } label: {
//                    Text("추가하기")
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//            }
//            .padding(16)
//            
//        }
//    }
//}
