//
//  ListModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ListModel: Identifiable {
    var name: String
    var groups: [GroupModel]
    
    var id: String {
        var idString = UUID().uuidString
        idString = idString + name + groups.description
        return idString
    }
}
