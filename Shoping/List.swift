//
//  List.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import Foundation

struct ListModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let groups: [GroupModel]
}

struct GroupModel {
    let name: String
    let order: Int
    let items: [ItemModel]
}

struct ItemModel {
    let name: String
    let order: Int
}
