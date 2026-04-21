//
//  Meeting.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/20/26.
//

import Foundation
import SwiftData

@Model
final class Meeting {
    var title: String
    var createdAt: Date
    var speakers: [Speaker] = []
    var timerSeconds: Int
    
    init(
        title: String,
        createdAt: Date = Date(),
        speakers: [Speaker] = [],
        timerSeconds: Int
    ) {
        self.title = title
        self.createdAt = createdAt
        self.speakers = speakers
        self.timerSeconds = timerSeconds
    }
}
