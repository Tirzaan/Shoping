//
//  InputTextEntity.swift
//  Shoping
//
//  Created by Tirzaan on 8/14/25.
//

import AppIntents

struct InputTextEntity: AppEntity {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Item and List")
    static var defaultQuery = InputTextQuery()
    
    var id: String
    var text: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: LocalizedStringResource(stringLiteral: text))
    }
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    static var allowsArbitraryStringValues: Bool { true }
}

struct InputTextQuery: EntityQuery, EntityStringQuery {
    func entities(for identifiers: [String]) async throws -> [InputTextEntity] {
        identifiers.map { InputTextEntity(id: $0, text: $0) }
    }
    
    func suggestedEntities() async throws -> [InputTextEntity] {
        [
            InputTextEntity(id: "milk to shopping list", text: "milk to shopping list"),
            InputTextEntity(id: "eggs to groceries", text: "eggs to groceries"),
            InputTextEntity(id: "bread to bakery", text: "bread to bakery")
        ]
    }
    
    func entities(matching string: String) async throws -> [InputTextEntity] {
        [InputTextEntity(id: string, text: string)]
    }
}
