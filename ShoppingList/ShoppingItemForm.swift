//
//  ShoppingItemForm.swift
//  ShoppingList
//
//  Created by dmu mac 26 on 03/11/2022.
//

import SwiftUI

struct ShoppingItemForm: View {
//    @EnvironmentObject var viewModel: ShoppingItemViewModel
    var viewModel: ShoppingItemViewModel
    @State private var name = ""
    @State private var amount = "0" // Must be string to be bound to TextField. We convert to int later.
    
    var body: some View {
        Form {
            TextField("Navn", text: $name)
            TextField("Antal", text: $amount)
            HStack(spacing: 20) {
                Button("Opret") {
                    viewModel.addByValue(name: name, amount: Int(amount)!)
                }
                Button("Annuller") {
                    
                }
            }
        }
        
    }
}

struct ShoppingItemForm_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemForm(viewModel: ShoppingItemViewModel())
    }
}
