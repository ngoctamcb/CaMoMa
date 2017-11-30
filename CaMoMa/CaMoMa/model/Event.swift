//
//  Event.swift
//  CaMoMa
//
//  Created by TranNgocTam on 11/27/17.
//  Copyright © 2017 TranNgocTam. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject {
    var id: String?
    var money: Int?
    var note: String?
    var date : String?
    
    init(id: String, money: Int, note: String, date: String) {
        self.id = id
        self.money = money
        self.note = note
        self.date = date
    }
    
}

