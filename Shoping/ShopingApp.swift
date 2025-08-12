//
//  ShopingApp.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import SwiftUI

@main
struct ShopingApp: App {
    
    @StateObject var viewModel = ShopingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListofListsView()
                .environmentObject(viewModel)
        }
    }
}
