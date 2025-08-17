//
//  AddGroupView.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import SwiftUI

struct AddGroupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ShopingViewModel
    
    @State var itemName: String = ""
    @State var itemOrderString: String = ""
    @State var itemOrder: String = ""
    
    @State var showItem: Bool = false
    
//    @State var newGroup: GroupModel = GroupModel(name: "", order: 0, items: [], currentItems: [])
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    TextField("name", text: $viewModel.currentGroup.name)
                    Section(header:
                                HStack {
                        Text("Items")
                            .font(.title2)
                        Spacer()
                        Button {
                            showItem = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                    ) {
                        ForEach(viewModel.currentGroup.items) { item in
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text("\(item.order)")
                                    .font(.headline)
                            }
                        }
                    }
                    TextField("Order", text: $viewModel.currentGroupOrderString)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            if let order = Int(viewModel.currentGroupOrderString) {
                                viewModel.currentGroupOrder = order
                            }
                        }
                }
                .sheet(isPresented: $showItem) {
                    AddItemView()
                }
                Spacer()
                
                Button {
                    Save()
                } label: {
                    Text(viewModel.isEditingGroup ? "Update" : "Save")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            .navigationTitle(viewModel.isEditingGroup ? "Edit Group" : "Add Group")
        }
        .listStyle(.grouped)
    }
}

extension AddGroupView {
    var ItemView: some View {
        HStack {
            TextField("Enter Item Name...", text: $itemName)
            TextField("0", text: $itemOrderString)
                .keyboardType(.numberPad)
        }
    }
}

extension AddGroupView {
    func Save() {
        viewModel.addGroup(group: viewModel.currentGroup)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddGroupView()
        .environmentObject(ShopingViewModel())
}
