//
//  AddListView.swift
//  Shoping
//
//  Created by Tirzaan on 7/30/25.
//

import SwiftUI

struct AddListView: View {
    
    @State var selectedList: ListModel = ListModel(name: "", groups: [
        GroupModel(name: "A", order: 0, items: []),
        GroupModel(name: "B", order: 1, items: [])
    ])
    
    @State var nameInput: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("name", text: $nameInput)
                
                List {
                    Section(header:
                                HStack {
                        Text("Groups")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            AddGroupView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                    ) {
                        ForEach(selectedList.groups.indices, id: \.self) { groupIndex in
                            Text(selectedList.groups[groupIndex].name)
                        }
                    }
                }
                .listStyle(.grouped)
                
                .navigationTitle("Add List")
            }
        }
    }
}

struct AddGroupView: View {
    
    @State var name: String = ""
    
    var body: some View {
        TextField("name", text: $name)
    }
}

#Preview {
    AddListView()
}
