//
//  RecordsStore.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 20.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import Foundation
import RealmSwift

class RecordsStore: Object {
    
    var records = List<RecordModel>()
    
}
