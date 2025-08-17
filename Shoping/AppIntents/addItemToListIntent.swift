//
//  addItemToListIn.swift
//  Shoping
//
//  Created by Tirzaan on 8/13/25.
//

import SwiftUI
import AppIntents

struct AddItemToListIntent: AppIntent {
    
//    @EnvironmentObject var viewModel: ShopingViewModel
    
    static var title: LocalizedStringResource = "Add Item to List"
    
    static var description = IntentDescription(
        "Adds an item to a list. Say something like 'In Shopper, add milk to shopping list to my list'.",
        categoryName: "Lists"
    )
    
    @Parameter(
        title: "Item and List",
        description: "Say something like 'milk to shopping list'."
    )
    var input: InputTextEntity
    
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let raw = input.text
        let parts = raw.components(separatedBy: " to ")
        let item = parts.first ?? raw
        let list = parts.count > 1 ? parts[1] : "Default List"
        
        print("Adding '\(item)' to '\(list)'")
//        viewModel.addItemToList(item: item, list: list)
        return .result(value: "Added \(item) to \(list).")
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$input) in ${applicationName}")
    }
}
