//
//  WaveformView.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct WaveformView: View {
    let levels: [CGFloat]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(levels, id: \.self) { level in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.blue)
                    .frame(width: 2, height: max(10, level))
            }
        }
        .frame(width: 110, height: 30)
        .clipped()
        .animation(.easeInOut(duration: 0.2), value: levels)
    }
}
