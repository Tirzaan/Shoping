//
//  ListModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

struct ListModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let groups: [GroupModel]
}
