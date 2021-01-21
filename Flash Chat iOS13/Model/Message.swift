//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Artem Shuliak  on 10/31/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
    
struct Message {
    let sender: String
    let body: String
    let date: Date
    
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        let date = dateFormatter.string(from: self.date)
        return date
    }
    
    var dateFromString: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        if let date = dateFormatter.date(from: stringDate) {
            return date
        }
        return date
    }
    
    
    
}
