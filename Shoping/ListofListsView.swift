//
//  ListofListsView.swift
//  Shoping
//
//  Created by Tirzaan on 7/29/25.
//

import SwiftUI

struct ListofListsView: View {
    
    @State var lists: [ListModel] = [
        ListModel(name: "To Do", groups: [GroupModel(name: "", order: 0, items: [])]),
        ListModel(name: "Grossery", groups: [
            GroupModel(name: "Veggies", order: 1, items: []),
            GroupModel(name: "Meat", order: 2, items: [])
        ]),
        ListModel(name: "Winco", groups: [GroupModel(name: "", order: 0, items: [])])
    ]
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = "Empty Alert"
    @State var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ListofLists(lists: $lists, showAlert: $showAlert, alertTitle: $alertTitle, alertMessage: $alertMessage)
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
            secondaryButton: .destructive(Text("DELETE")),
        )
    }
}

struct ListofLists: View {
    
    @Binding var lists: [ListModel]
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    
    var body: some View {
        List {
            ForEach(lists) { list in
                NavigationLink {
                    ListView()
                } label: {
                    HStack {
                        Text(list.name)
                        Spacer()
                        Menu {
                            NavigationLink("Edit") { Text("Editing '\(list.name)'") }
                            Button("Delete") {
                                alertTitle = "Are You Sure You Want To Delete '\(list.name)' List?"
                                alertMessage = "By clicking delete, this list will be permanently removed."
                                showAlert.toggle()
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
                Image(systemName: "plus")
                    .onTapGesture {
                        print("SUCCESS")
                    }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        lists.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    ListofListsView()
}
