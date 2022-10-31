//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by dmu mac 26 on 03/11/2022.
//

import Foundation

class ShoppingItemViewModel: ObservableObject {
    @Published var shoppingItems = [ShoppingItem]() // Shorthand for [ShoppingItem] = []
    
    private var dbService = FirebaseService()
    
    init() {
        self.listenForData()
    }
    
    func addByValue(name: String, amount: Int) {
        let shoppingItem = ShoppingItem(name: name, amount: amount)
        let newId = dbService.add(item: shoppingItem)
        print(String(describing: newId))
    }
    
    func addByItem(shoppingItem: ShoppingItem) {
        let newId = dbService.add(item: shoppingItem)
        print(String(describing: newId))
    }
    
    func getAll() {
        Task {
            shoppingItems = await dbService.getAll()
        }
    }
    
    func listenForData() {
        dbService.listenForData { items in
            self.shoppingItems = items
        }
    }
    
}
