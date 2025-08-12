//
//  AddListView.swift
//  Shoping
//
//  Created by Tirzaan on 7/30/25.
//

import SwiftUI

struct AddListView: View {
    
    @EnvironmentObject var viewModel: ShopingViewModel
    
    @State var newList: ListModel = ListModel(name: "", groups: [
        GroupModel(name: "A", order: 0, items: [], currentItems: []),
        GroupModel(name: "B", order: 1, items: [], currentItems: [])
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
                        ForEach(newList.groups) { group in
                            Text(group.name)
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
        newList.name = nameInput
        viewModel.lists.append(newList)
    }
    
}



#Preview {
    AddListView()
        .environmentObject(ShopingViewModel())
}
