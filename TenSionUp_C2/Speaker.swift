//
//  Speaker.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//

import Foundation

enum TimeState: String, Codable {
    case notStarted
    case running
    case paused
    case ended
}

struct Speaker: Codable, Identifiable {
    let id : UUID
    var name: String
    var image: String
    var time: Int                               // 1인당 발화 시간
    var timeState: TimeState = .notStarted
    var speakingSeconds: Int                    // 말하는 시간
    var listeningSeconds: Int                   // 들은 시간 time - speakingSeconds
    
    init(
        id: UUID = UUID(),
        name: String, image:
        String, time: Int,
        speakingSeconds: Int = 0,
        listeningSeconds: Int = 0
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.time = time
        self.speakingSeconds = speakingSeconds
        self.listeningSeconds = listeningSeconds
    }
}
