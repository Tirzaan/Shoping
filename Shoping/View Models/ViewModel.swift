//
//  ViewModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

class ShopingViewModel: ObservableObject {
    
    @Published var lists: [ListModel] = [
        ListModel(name: "To Do", groups: [GroupModel(name: "", order: 0, items: [], currentItems: [])]),
        ListModel(name: "Grossery", groups: [
            GroupModel(name: "Veggies", order: 1, items: [], currentItems: []),
            GroupModel(name: "tytyt", order: 1, items: [], currentItems: []),
            GroupModel(name: "Meat", order: 2, items: [], currentItems: [])
        ]),
        ListModel(name: "Winco", groups: [GroupModel(name: "", order: 0, items: [], currentItems: [])])
    ]
    
    @Published var currentList: ListModel = ListModel(name: "", groups: [])
    
    @Published var isEditing: Bool = false
    
    func addList(list: ListModel) {
        let newList = ListModel(name: list.name, groups: list.groups)
        lists.append(newList)
    }
    
    func addGroup(group: GroupModel) {
        let newGroup: GroupModel = group
        currentList.groups.append(newGroup)
    }
    
    func addItem(list: ListModel) {
        
    }
    
}
