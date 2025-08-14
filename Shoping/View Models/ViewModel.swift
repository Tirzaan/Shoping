//
//  ViewModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

class ShopingViewModel: ObservableObject {
    
    @Published var lists: [ListModel] = [
        ListModel(name: "To Do", groups: [GroupModel(name: "Shopping", order: 0, items: [
            ItemModel(name: "Apples", order: 0)
        ], currentItems: [])]),
        ListModel(name: "Grossery", groups: [
            GroupModel(name: "Veggies", order: 1, items: [], currentItems: []),
            GroupModel(name: "tytyt", order: 1, items: [], currentItems: []),
            GroupModel(name: "Meat", order: 2, items: [], currentItems: [])
        ]),
        ListModel(name: "Winco", groups: [GroupModel(name: "", order: 0, items: [], currentItems: [])])
    ]
    
    @Published var currentList: ListModel = ListModel(name: "", groups: [])
    
    @Published var isEditingList: Bool = false
    @Published var isEditingGroup: Bool = false
    
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
        currentList.groups.removeAll(where: { $0.id == currentGroup.id })
        currentList.groups.append(newGroup)
        organizeGroups()
    }
    
    func addItem(group: GroupModel, item: ItemModel) {
        var newGroup: GroupModel = group
        newGroup.items.append(item)
        currentGroup = newGroup
        organizeItems(group: group)
    }
    
    func addItemToList(item: String, list: String) {
        guard !item.isEmpty else {
            print("item is empty 🫥")
            return
        }
        guard !list.isEmpty else {
            print("list is empty 🫥")
            return
        }
        
        var addingItem = ItemModel(name: item, order: 0)
        guard var addingList: ListModel = lists.first(where: { $0.name == list }) else {
            print("List does not exist 🫥")
            return
        }
        
        
        addingList.groups.forEach { group in
            
            
                
                if group.items.contains(where: { $0.name == item }) {
                    
                    if let groupIndex: Int = addingList.groups.firstIndex(where: { $0.name == group.name }) {
                        print("Put Item in \(group.name)")
                        addingList.groups[groupIndex].currentItems.append(addingItem)
                        if let listIndex: Int = lists.firstIndex(where: { $0.name == list }) {
                            lists[listIndex] = addingList
                        }
                    } else {
                        print("ERROR: Group \(group.name) does not exist")
                    }
                    
                } else {
                    
                    if let otherGroupIndex: Int = addingList.groups.firstIndex(where: { $0.name == "Other" }) {
                        print("Put Item in \(group.name)")
                        addingList.groups[otherGroupIndex].currentItems.append(addingItem)
                    } else {
                        print("ERROR: Group Other does not exist")
                    }
                
//                    if var otherGroup: GroupModel = addingList.groups.last {
//                        print("Put Item in Other")
//                        otherGroup.currentItems.append(addingItem)
//                         //.currentItems.append(addingItem)
//                    } else {
//                        print("ERROR: Group Other does not exist")
//                    }
                    
                }
        }
        
    }
    
}


//                    print("Put Item in \(group.name)")
//                    addingGroup.currentItems.append(addingItem)
//                    addingList.groups.first(where: { $0.name == group.name })!.currentItems.append(addingItem)
