//
//  ListModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ListModel: Identifiable {
    let id = UUID().uuidString
    var name: String
    var groups: [GroupModel]
}
