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
    
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
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
            .alert(isPresented: $showAlert) { GetAlert() }
            .navigationTitle(viewModel.isEditing ? "Edit List" :"Add List")
        }
    }
}

extension AddListView {
    
    func Save() {
        if TextisAppropriate() {
            viewModel.currentList.name = nameInput
            viewModel.addList(list: viewModel.currentList)
//            viewModel.lists.removeAll(where: { $0.id == viewModel.currentList.id })
//            viewModel.lists.append(viewModel.currentList)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func TextisAppropriate() -> Bool {
        if nameInput.isEmpty || nameInput == " " || nameInput == "  " || nameInput == "   " {
            alertTitle = "Name is Empty! 🫥"
            alertMessage = "Please enter a name for your list."
            showAlert = true
            return false
        } else if nameInput.contains("") {
            alertTitle = "Name Has inappropriates Words!"
            alertMessage = "Please change the name of your list."
            showAlert = true
            return false
        } else {
            return true
        }
    }
    
    func GetAlert() -> Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
        )
    }

    
}



#Preview {
    AddListView()
        .environmentObject(ShopingViewModel())
}
