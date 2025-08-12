//
//  ListView.swift
//  Shoping
//
//  Created by Tirzaan on 8/5/25.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var viewModel: ShopingViewModel
    
//    @State var list: ListModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.currentList.groups) { group in
                        Section(header:
                            Text("\(group.name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        ) {
                            ForEach(group.currentItems.indices) { item in
                                Text(group.currentItems[item].name)
                            }
                        }
                    }
                    Section(header:
                        Text("Other")
                            .font(.title2)
                            .fontWeight(.semibold)
                    ) {
//                        ForEach(group.items.indices) { item in
//                            Text(group.items[item].name)
//                        }
                    }
                }
            }
            .navigationTitle("\(viewModel.currentList.name)")
        }
    }
}

#Preview {
    ListView()
        .environmentObject(ShopingViewModel())
}
