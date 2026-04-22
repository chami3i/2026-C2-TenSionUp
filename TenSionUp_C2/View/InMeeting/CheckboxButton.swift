//
//  CheckboxButton.swift
//  TenSionUp_C2
//
//  Created by chaem on 4/22/26.
//

import SwiftUI

struct CheckboxButton: View {
    @State var isCheck : Bool = false
    let checkColor: Color = Color.white
    let backgroundColor: Color = Color(.gray)
    let checkSize: CGFloat = 12.5
    let cornerRadius: CGFloat = 5
    let backgroundSize: CGFloat = 15
    
    var body: some View {
        Button {
           isCheck = !isCheck
        } label: {
            if isCheck {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(backgroundColor)
                            .frame(width: backgroundSize, height: backgroundSize)
                        Image(systemName: "checkmark")
                            .foregroundStyle(checkColor)
                            .frame(width: backgroundSize, height: backgroundSize)
                    }
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(lineWidth: 0.2)
                    .foregroundStyle(Color.black)
                    .frame(width: backgroundSize, height: backgroundSize)
                }
            }
    }
}

#Preview {
    CheckboxButton(isCheck: false)
}
