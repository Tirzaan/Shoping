//
//  ViewModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

class ShopingViewModel: ObservableObject {
    
    @Published var lists: [ListModel] = [
        ListModel(name: "To Do", groups: [GroupModel(name: "", order: 0, items: [])]),
        ListModel(name: "Grossery", groups: [
            GroupModel(name: "Veggies", order: 1, items: []),
            GroupModel(name: "Meat", order: 2, items: [])
        ]),
        ListModel(name: "Winco", groups: [GroupModel(name: "", order: 0, items: [])])
    ]
    
}
