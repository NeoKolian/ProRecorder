//
//  MyItem.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 20.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
        dynamic var ID = 0
        dynamic var textString = ""
        override static func primaryKey() -> String? {
              return "ID"
        }
}
