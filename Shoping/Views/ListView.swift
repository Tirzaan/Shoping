//
//  ListView.swift
//  Shoping
//
//  Created by Tirzaan on 8/5/25.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var viewModel = ShopingViewModel()
    
    @State var list: ListModel = ListModel(
        name: "To Do",
        groups: [
            GroupModel(name: "one", order: 1, items: [
                ItemModel(name: "item", order: 2)
            ]),
            GroupModel(name: "two", order: 1, items: [
                ItemModel(name: "something", order: 2),
                ItemModel(name: "wow", order: 4)
            ]),
            
            GroupModel(name: "Other", order: 1, items: [
                ItemModel(name: "something weard", order: 2),
                ItemModel(name: "nope", order: 4),
                ItemModel(name: "look at that", order: 6),
                ItemModel(name: "Ice", order: 9)
            ])
        ])
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(list.groups.indices) { groupIndex in
                        Section(header:
                            Text("\(list.groups[groupIndex].name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        ) {
                            ForEach(list.groups[groupIndex].items.indices) { item in
                                Text(list.groups[groupIndex].items[item].name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(list.name)")
        }
    }
}

#Preview {
    ListView()
}
