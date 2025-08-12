//
//  AddListView.swift
//  Shoping
//
//  Created by Tirzaan on 7/30/25.
//

import SwiftUI

struct AddListView: View {
    
    @StateObject var viewModel = ShopingViewModel()
    
    @State var newList: ListModel = ListModel(name: "", groups: [
        GroupModel(name: "A", order: 0, items: []),
        GroupModel(name: "B", order: 1, items: [])
    ])
    
    @State var nameInput: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    TextField("name", text: $nameInput)
                    
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
                        ForEach(newList.groups.indices, id: \.self) { groupIndex in
                            Text(newList.groups[groupIndex].name)
                        }
                        .onDelete { IndexSet in }
                    }
                }
                .listStyle(.grouped)
                
                Button {
                    Save()
                } label: {
                    Text("Save")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
            .navigationTitle("Add List")
        }
    }
}

extension AddListView {
    
    func Save() {
        viewModel.lists.append(newList)
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
