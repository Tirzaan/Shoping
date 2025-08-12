//
//  AddListView.swift
//  Shoping
//
//  Created by Tirzaan on 7/30/25.
//

import SwiftUI

struct AddListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: ShopingViewModel
    
//    @State var viewModel.currentList: ListModel = ListModel(name: "", groups: [
//        GroupModel(name: "A", order: 0, items: [], currentItems: []),
//        GroupModel(name: "B", order: 1, items: [], currentItems: [])
//    ])
    
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
                        ForEach(viewModel.currentList.groups) { group in
                            Text(group.name)
                        }
                        .onDelete { IndexSet in }
                    }
                }
                .listStyle(.grouped)
                
                Button {
                    Save()
                } label: {
                    Text(viewModel.isEditing ? "Update" :"Save")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
            .navigationTitle(viewModel.isEditing ? "Edit List" :"Add List")
        }
    }
}

extension AddListView {
    
    func Save() {
        if TextisAppropriate() {
            viewModel.currentList.name = nameInput
            viewModel.lists.removeAll(where: { $0.id == viewModel.currentList.id })
            viewModel.lists.append(viewModel.currentList)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func TextisAppropriate() -> Bool {
        return !nameInput.isEmpty
    }
    
}



#Preview {
    AddListView()
        .environmentObject(ShopingViewModel())
}
