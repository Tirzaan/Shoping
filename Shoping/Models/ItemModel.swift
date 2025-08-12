//
//  ItemModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ItemModel: Identifiable {
    var name: String
    var order: Int
    
    var id: String {
        var idString = UUID().uuidString
        idString = idString + name + "\(order)"
        return idString
    }
}
