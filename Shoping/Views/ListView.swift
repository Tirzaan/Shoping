//
//  ListView.swift
//  Shoping
//
//  Created by Tirzaan on 8/5/25.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var viewModel: ShopingViewModel
    
    @State var list: ListModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(list.groups.indices) { groupIndex in
                        Section(header:
                            Text("\(list.groups[groupIndex].name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                        ) {
                            ForEach(list.groups[groupIndex].items.indices) { item in
                                Text(list.groups[groupIndex].items[item].name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(list.name)")
        }
    }
}

#Preview {
    ListView(list: ListModel(name: "www", groups: []))
        .environmentObject(ShopingViewModel())
}
