//
//  FetchingMessages.swift
//  
//
//  Created by Artem Shuliak  on 1/10/21.
//

import UIKit
import Firebase


class FetchingMessages {
    
    let db = Firestore.firestore()
    
    var chatMessages = [[Message]]()
    
    func loadMessages(completion: @escaping ([[Message]]) -> ()) {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                var messages: [Message] = []
                self.chatMessages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String, let date = data[K.FStore.dateField] as? Timestamp {
                                let newMessage = Message(sender: messageSender, body: messageBody, date: date.dateValue())
                                messages.append(newMessage)
                            }
                        }
                    }
                    
                    let groupedMessages = Dictionary(grouping: messages) { (message) -> Date in
                        message.dateFromString
                    }
                    
                    let sortedKeys = groupedMessages.keys.sorted()
                    
                    sortedKeys.forEach { (key) in
                        let values = groupedMessages[key]
                        let sortedValues = values?.sorted(by: { $0.date < $1.date })
                        
                        self.chatMessages.append(sortedValues ?? [])
                        
                        completion(self.chatMessages)
                    }
                }
            }
    }
    
    func uploadMessages(messageBody: String, messageSender: String) {
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField : messageSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date()
        ]) { (error) in
            if let e = error {
                print("There was an issue saving data to Firestore, \(e) ")
            } else {
                print("Sucessfully saved data.")
            }
        }
    }
    
    
    
    
    
}

