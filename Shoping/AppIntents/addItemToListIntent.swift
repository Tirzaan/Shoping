//
//  addItemToListIn.swift
//  Shoping
//
//  Created by Tirzaan on 8/13/25.
//

import AppIntents

/// This intent is triggered when the user says something like:
/// "Add Milk to Shopping List"
struct AddItemToListIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Add Item to List"
    static var description = IntentDescription(
        "Adds an item to a specific list.",
        categoryName: "Lists"
    )
    
    // MARK: - Parameters
    
    @Parameter(
        title: "Item",
        description: "The item to add to the list."
    )
    var item: String
    
    @Parameter(
        title: "List",
        description: "The name of the list where the item will be added."
    )
    var list: String
    
    // MARK: - Perform Action
    
    func perform() async throws -> some IntentResult {
        // Here you would integrate with your app’s list data model
        print("Adding \(item) to \(list)")
        
        // For now, we’ll just return a confirmation message to Siri
        return .result(
            value: "\(item) has been added to \(list)."
        )
    }
    
    // MARK: - Suggested Invocation
    
    static var parameterSummary: some ParameterSummary {
        Summary("Add \(\.$item) to \(\.$list)")
    }
}
