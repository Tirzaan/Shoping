//
//  GroupModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct GroupModel: Identifiable {
    var name: String
    var order: Int
    var items: [ItemModel]
    var currentItems: [ItemModel]
    
    var id: String {
        var idString = UUID().uuidString
        idString = idString + name + "\(order)" + items.description
        return idString
    }
}
