//
//  SwiftUIView.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        List {
            ForEach(0..<100, id: \.self) {
                Text("\($0)")
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
