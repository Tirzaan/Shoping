//
//  AddItemView.swift
//  Shoping
//
//  Created by Tirzaan on 8/11/25.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ShopingViewModel
    
    @State var name: String = ""
    @State var orderString: String = ""
    @State var order: Int = 0
    
//    @State var newGroup: GroupModel
    @State var newItem: ItemModel = ItemModel(name: "", order: 0)
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    TextField("name", text: $name)
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
            .navigationTitle("Add Item")
        }
    }
}

extension AddItemView {
    func Save() {
        if let order = Int(orderString) {
            self.order = order
        }
        newItem.name = name
        newItem.order = order
        viewModel.addItem(item: newItem)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddItemView()
        .environmentObject(ShopingViewModel())
}
