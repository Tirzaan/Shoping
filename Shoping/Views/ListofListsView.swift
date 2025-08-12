//
//  ListofListsView.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import SwiftUI

struct ListofListsView: View {
    
    @StateObject var viewModel = ShopingViewModel()
    
//    @State var lists: [ListModel] = [
//        ListModel(name: "To Do", groups: [GroupModel(name: "", order: 0, items: [])]),
//        ListModel(name: "Grossery", groups: [
//            GroupModel(name: "Veggies", order: 1, items: []),
//            GroupModel(name: "Meat", order: 2, items: [])
//        ]),
//        ListModel(name: "Winco", groups: [GroupModel(name: "", order: 0, items: [])])
//    ]
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = "Empty Alert"
    @State var alertMessage: String = ""
    @State var selectedList: ListModel = ListModel(name: "", groups: [])
    
    init() {
        selectedList = viewModel.lists.first ?? ListModel(name: "", groups: [])
    }
    
    var body: some View {
        NavigationStack {
            ListofLists(showAlert: $showAlert, alertTitle: $alertTitle, alertMessage: $alertMessage, selectedList: $selectedList)
            .alert(isPresented: $showAlert) { GetAlert() }
            
            .navigationTitle("Lists")
        }
    }
}

extension ListofListsView {
    func GetAlert() -> Alert {
        Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            primaryButton: .cancel(),
            secondaryButton: .destructive(Text("DELETE")) {
                viewModel.lists.removeAll(where: { $0.name == selectedList.name })
            },
        )
    }
}

struct ListofLists: View {
    
    @StateObject var viewModel = ShopingViewModel()
    
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    
    @Binding var selectedList: ListModel
    
    var body: some View {
        List {
            ForEach(viewModel.lists) { list in
                NavigationLink {
                    ListView()
                } label: {
                    HStack {
                        Text(list.name)
                        Spacer()
                        Menu {
                            NavigationLink("Edit") { Text("Editing '\(list.name)'") }
                            Button("Delete") {
                                deleteButton(list: list)
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
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddListView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        viewModel.lists.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteButton(list: ListModel) {
        alertTitle = "Are You Sure You Want To Delete '\(list.name)' List?"
        alertMessage = "By clicking delete, this list will be permanently removed."
        selectedList = viewModel.lists.first(where: { $0.name == list.name }) ?? ListModel(name: "", groups: [])
        showAlert.toggle()
    }
    
}

#Preview {
    ListofListsView()
}
