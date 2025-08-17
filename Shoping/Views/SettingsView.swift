//
//  SettingsView.swift
//  Shoping
//
//  Created by Tirzaan on 8/14/25.
//

import SwiftUI

struct SettingsOption: View {
    
    @State var text: String
    @State var imageName: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: imageName)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                SettingsOption(text: "Account", imageName: "person.fill")
                SettingsOption(text: "Language", imageName: "globe")
                SettingsOption(text: "Theme", imageName: "paintbrush.fill")
                SettingsOption(text: "Audio / Haptics", imageName: "waveform")
                SettingsOption(text: "Notifications", imageName: "bell.fill")
            }
            .font(.title2)
            .fontWeight(.semibold)
            
            .navigationTitle("Settings ⚙️")
        }
    }
}

#Preview {
    SettingsView()
}
