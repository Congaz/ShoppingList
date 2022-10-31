//
//  Item.swift
//  ShoppingList
//
//  Created by dmu mac 26 on 31/10/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ShoppingItem: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    var amount: Int = 1

    
}
