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
    
    @State var name: String = ""
    @State var orderString: String = ""
    @State var order: Int = 0
    
//    @State var newGroup: GroupModel = GroupModel(name: "", order: 0, items: [], currentItems: [])
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    TextField("name", text: $name)
                    Section(header:
                                HStack {
                        Text("Items")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            AddItemView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                    ) {
                        ForEach(viewModel.currentGroup.items) { item in
                            Text(item.name)
                        }
                    }
                    TextField("Order", text: $orderString)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            if let order = Int(orderString) {
                                self.order = order
                            }
                        }
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
    func Save() {
        viewModel.currentGroup.name = name
        viewModel.addGroup(group: viewModel.currentGroup)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddGroupView()
        .environmentObject(ShopingViewModel())
}
