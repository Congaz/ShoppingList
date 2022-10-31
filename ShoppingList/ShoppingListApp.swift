//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by dmu mac 26 on 31/10/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


@main
struct ShoppingListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ShoppingItemViewModel())
        }
    }
}
