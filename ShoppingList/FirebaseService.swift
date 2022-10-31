//
//  FirebaseService.swift
//  ShoppingList
//
//  Created by dmu mac 26 on 31/10/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseService {
    private let dbRef = Firestore.firestore()
    private var ref: DocumentReference?
    private let collectionRef: CollectionReference?
    
    init() {
        collectionRef = dbRef.collection("shoppingList")
    }
    
    func getAll() async -> [ShoppingItem] {
        guard let collectionRef = collectionRef else {return []}
        var items: [ShoppingItem] = []
        do {
            let snapshot = try await collectionRef.getDocuments()
            items = snapshot.documents.compactMap{ queryDocumentSnapshot in
                return try! queryDocumentSnapshot.data(as: ShoppingItem.self)
            }
        }
        catch {
            print(error)
        }
        return items
    }
    
    // Returns item with newly created id
    func add1(item: ShoppingItem) -> ShoppingItem {
        var newItem = item
        do {
            let newDocumentReference = try collectionRef?.addDocument(from: item)
            print("New ShoppingItem created with id: \(newDocumentReference?.documentID)")
            newItem.id = newDocumentReference?.documentID
            // newDocumentReference.data().name
        }
        catch {
            print(error)
        }
        return newItem
    }
    
    // Returns newly created id
    func add(item: ShoppingItem) -> String? {
        var id: String?
        do {
            let newDocumentReference = try collectionRef?.addDocument(from: item)
            print("New ShoppingItem created with id: \(newDocumentReference?.documentID)")
            id = newDocumentReference?.documentID
            // newDocumentReference.data().name
        }
        catch {
            print(error)
        }
        return id
    }
    
    func delete(item: ShoppingItem) {
        guard let id = item.id, let docRef = collectionRef?.document(id) else {return}
        docRef.delete()
    }
    
    func deleteById(_ itemId: String?) {
        guard let id = itemId else {
            print("DeleteById: itemId not in DB.")
            return
        }
        // Returns deleted item
        let deletedItem = collectionRef?.document(id).delete()
        print("Deleted ShoppingItemId: \(id)")
    }
    
    func update(_ item: ShoppingItem) {
        guard let id = item.id, let docRef = collectionRef?.document(id) else {
            print("update: Item has no id and/or id is not in DB.")
            return
        }
        do {
            try docRef.setData(from: item)
        }
        catch {
            print(error)
        }
    }
    
    // Dummy
//    func oldschoolAdd() {
//        // Creates collection if it doesn't exist
//        ref = dbRef.collection("shoppingList").addDocument(data: ["emne" : "mælk"]) {
//            // Closing trail
//            err in
//            if let err = err {
//                print("Error")
//            }
//            else {
//                print("Document is created with id: \(self.ref!.documentID) ")
//            }
//
//        }
//    }
    
    func listenForData(_ completionHandler: @escaping ([ShoppingItem]) -> ()) {
        guard let collectionRef = collectionRef else {return}
        collectionRef.addSnapshotListener { QuerySnapshot, error in
            guard let documents = QuerySnapshot?.documents else { return }
            let items = documents.compactMap{(item) -> ShoppingItem? in
                return try? item.data(as: ShoppingItem.self)
            }
            completionHandler(items)
        }
    }
    
}
