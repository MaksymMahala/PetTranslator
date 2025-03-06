//
//  RecordButton.swift
//  TestApp
//
//  Created by Max on 05.03.2025.
//

import SwiftUI

struct RecordButton: View {
    let isRecording: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                if !isRecording {
                    Image(.microphone)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                }
                
                Text(isRecording ? "Recording..." : "Start Speaking")
                    .font(Font.konkhmerSleokchherRegular16)
                    .foregroundStyle(Color.primary)
            }
        }
    }
}
