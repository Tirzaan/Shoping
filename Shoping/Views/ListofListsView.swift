//
//  ListofListsView.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import SwiftUI

struct ListofListsView: View {
    //MARK: VARIABLES
    @EnvironmentObject var viewModel: ShopingViewModel
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = "Empty Alert"
    @State var alertMessage: String = ""
    @State var selectedList: ListModel = ListModel(name: "", groups: [])
    
    @State var navigateToList: Bool = false
    @State var navigateToNewList: Bool = false
    
    var body: some View {
        NavigationStack {
            listofLists
            NavigationLink("", destination: ListView(), isActive: $navigateToList).hidden()
            NavigationLink("", destination: AddListView(), isActive: $navigateToNewList).hidden()
            .alert(isPresented: $showAlert) { GetAlert() }
            .navigationTitle("Lists")
        }
    }
}

//MARK: VIEWS
extension ListofListsView {
    var listofLists: some View {
        List {
            ForEach(viewModel.lists) { list in
                Button {
                    viewModel.currentList = list
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        navigateToList = true
                    })
                } label: {
                    HStack {
                        Text(list.name)
                        Spacer()
                        Menu {
                            Button("Edit") {
                                viewModel.isEditingList = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                                    navigateToNewList = true
                                })
                            }
                            Button("Delete") {
                                deleteItemAlert(list: list)
                            }

                        } label: {
                            Image(systemName: "ellipsis")
                                .padding(5)
                        }
                        .tint(.primary)
                    }
                }
            }
            .onMove(perform: moveItem)
            
            Button("Add Apples to To Do") {
                viewModel.addItemToList(item: "Apples", list: "To Do")
            }
        }
        .onAppear {
            viewModel.isEditingList = false
            viewModel.isEditingGroup = false
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.currentList = ListModel(name: "", groups: [])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        navigateToNewList = true
                    })
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
    }
}



//MARK: FUCTIONS
extension ListofListsView {
    func GetAlert() -> Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            primaryButton: .cancel(),
            secondaryButton: .destructive(Text("DELETE")) {
                deleteItem()
            },
        )
    }
    
    func deleteItem() {
        viewModel.lists.removeAll(where: { $0.name == selectedList.name })
        print("Deleted \(selectedList.name) List")
        print(viewModel.lists.description)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        viewModel.lists.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteItemAlert(list: ListModel) {
        alertTitle = "Are You Sure You Want To Delete '\(list.name)' List?"
        alertMessage = "By clicking delete, this list will be permanently removed."
        selectedList = viewModel.lists.first(where: { $0.name == list.name }) ?? ListModel(name: "", groups: [])
        showAlert.toggle()
    }
}


//MARK: PREVIEW
#Preview {
    ListofListsView()
        .environmentObject(ShopingViewModel())
}
