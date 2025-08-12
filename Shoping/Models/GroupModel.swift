//
//  GroupModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct GroupModel: Identifiable {
    let id: String = UUID().uuidString
    var name: String
    var order: Int
    var items: [ItemModel]
    var currentItems: [ItemModel]
}
