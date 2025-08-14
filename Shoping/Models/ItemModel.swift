//
//  ItemModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ItemModel: Identifiable {
    let id = UUID().uuidString
    var name: String
    var order: Int
}
