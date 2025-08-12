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
    
    var currentGroup: GroupModel = GroupModel(name: "", order: 0, items: [], currentItems: [])
    
    init() {
        organizeLists()
    }
    
    func organizeLists() {
        lists.sort { $0.name < $1.name }
    }
    
    func organizeGroups() {
        currentList.groups.sort { $0.order < $1.order }
    }
    
    func organizeItems(group: GroupModel) {
        var currentgroup = group
        currentgroup.items.sort { $0.order < $1.order }
    }
    
    func organizeCurrentItems(group: GroupModel) {
        var currentgroup = group
        currentgroup.currentItems.sort { $0.order < $1.order }
    }
    
    func addList(list: ListModel) {
        let groups: [GroupModel] = list.groups
        let newList = ListModel(name: list.name, groups: groups)
        lists.removeAll(where: { $0.id == currentList.id })
        lists.append(newList)
        organizeGroups()
        organizeLists()
    }
    
    func addGroup(group: GroupModel) {
        let newGroup: GroupModel = group
        currentList.groups.append(newGroup)
        organizeGroups()
    }
    
    func addItem(group: GroupModel, item: ItemModel) {
        var newGroup: GroupModel = group
        newGroup.items.append(item)
        currentGroup = newGroup
        organizeItems(group: group)
    }
    
}
