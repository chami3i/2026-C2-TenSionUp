//
//  InMeetingView.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/21/26.
//

import SwiftUI

struct InMeetingView: View {
    let meetingName: String
    
    var body: some View {
        VStack {
            Divider()
            
            Text(meetingName)
                .font(.title2)
                .bold()
            
            Divider()
            
            Text("말할 사람을 선택해주세요.")
            
            
        }
    }
}

#Preview {
    InMeetingView(meetingName: "텐션업")
}
