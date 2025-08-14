//
//  MyAppShortcuts.swift
//  Shoping
//
//  Created by Tirzaan on 8/13/25.
//

import AppIntents

struct MyAppShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddItemToListIntent(),
            phrases: [
                "In ${applicationName}, add \(\.$input) to my list", // "In Shopper, add milk to shopping list to my list"
                "Add \(\.$input) to my ${applicationName} list", // "Add milk to shopping list to my Shopper list"
                "Put \(\.$input) in ${applicationName} list", // "Put milk to shopping list in Shopper list"
                "In ${applicationName}, put \(\.$input)", // "In Shopper, put milk to shopping list"
                "Add \(\.$input) in ${applicationName}" // "Add milk to shopping list in Shopper"
            ],
            shortTitle: "Add Item",
            systemImageName: "plus"
        )
    }
}
