//
//  ViewModel.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import Foundation

class ShopingViewModel: ObservableObject {
    
    @Published var lists: [ListModel] = []
    
    @Published var currentList: ListModel = ListModel(name: "", groups: [])
    @Published var currentGroupOrderString: String = "0"
    @Published var currentGroupOrder: Int = 0
    
    @Published var isEditingList: Bool = false
    @Published var isEditingGroup: Bool = false
    
    @Published var currentGroup: GroupModel = GroupModel(name: "", order: 0, items: [], currentItems: [])
    
    let otherGroup: GroupModel = GroupModel(name: "Other", order: 0, items: [], currentItems: [])
    
    enum ListSortOptions {
        case sortByName
        case sortByOrder
        case sortByQuantity
        case sortByLastUpdated
        case sortByCreationDate
    }
    
    enum GroupSortOptions {
        case sortByName
        case sortByOrder
        case sortByQuantity
        case sortByLastUpdated
        case sortByCreationDate
    }
    
    enum ItemSortOptions {
        case sortByName
        case sortByOrder
        case sortByQuantity
        case sortByLastUpdated
        case sortByCreationDate
    }
    
    
    init() {
        organizeLists()
    }
    
    func organizeLists() {
//        let sortOptions: ListSortOptions = .sortByName
//        
//        switch sortOptions {
//            case .sortByName:
//
//            case .sortByOrder:
//                print("")
//            case .sortByQuantity:
//                print("")
//            case .sortByLastUpdated:
//                print("")
//            case .sortByCreationDate:
//                print("")
//            
//        }
        
        lists.sort { $0.name < $1.name }
        
    }
    
    func organizeGroups() {
        guard let otherGroup = currentList.groups.first(where: { $0.name == otherGroup.name }) else { return }
        currentList.groups.sort { $0.order < $1.order }
        if let index = currentList.groups.firstIndex(of: otherGroup) {
            currentList.groups.move(fromOffsets: IndexSet([index]), toOffset: currentList.groups.count)
            print("Moving '\(otherGroup.name)' to end (\(currentList.groups.count))")
            print("\(index)")
        }
        
    }
    
    func organizeItems() {
        currentGroup.items.sort { $0.order < $1.order }
    }
    
    func organizeCurrentItems(group: GroupModel) {
        var currentgroup = group
        currentgroup.currentItems.sort { $0.order < $1.order }
    }
    
    func addList(list: ListModel) {
        var groups: [GroupModel] = list.groups
        if !groups.contains(where: { $0.name == otherGroup.name }) {
            groups.append(otherGroup)
        }
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
    
    func addItem(item: ItemModel) {
        var group = currentGroup
        group.items.append(item)
        currentGroup = group
        organizeItems()
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
        
        let addingItem = ItemModel(name: item, order: 0)
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
                } else if let otherGroupIndex = addingList.groups.firstIndex(where: { $0.name == "Other" }) {
                    print("Put Item in \(group.name)")
                    addingList.groups[otherGroupIndex].currentItems.append(addingItem)
                    if let listIndex: Int = lists.firstIndex(where: { $0.name == list }) {
                        lists[listIndex] = addingList
                    } else {
                        print("ERROR: Group \(group.name) does not exist")
                    }
                    
                }
            }
        }
    }
}
