//
//  ItemModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let order: Int
}
