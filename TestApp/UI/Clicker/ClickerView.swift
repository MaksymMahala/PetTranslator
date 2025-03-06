//
//  ClickerView.swift
//  TestApp
//
//  Created by Max on 04.03.2025.
//

import SwiftUI

struct ClickerView: View {
    @ObservedObject private var viewModel = ClickerViewModel()
    
    var body: some View {
        VStack {
            Text("Settings")
                .foregroundStyle(Color.primary)
                .font(.konkhmerSleokchherRegular32)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.settingsList, id: \.self) { setting in
                        SettingsCell(setting: setting)
                    }
                }
            }
        }
    }
}

#Preview {
    ClickerView()
}
