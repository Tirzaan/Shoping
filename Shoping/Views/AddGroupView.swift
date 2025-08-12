//
//  AddGroupView.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import SwiftUI

struct AddGroupView: View {
    
    @State var name: String = ""
    @State var orderString: String = ""
    @State var order: Int = 0
    
    @State var newGroup: GroupModel = GroupModel(name: "ONE", order: 0, items: [], currentItems: [])
    
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
                        ForEach(newGroup.items) { item in
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
            
            .navigationTitle("Add Group")
        }
        .listStyle(.grouped)
    }
}

#Preview {
    AddGroupView()
}
