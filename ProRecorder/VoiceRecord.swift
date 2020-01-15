//
//  VoiceRecord.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 14.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import Foundation
import RealmSwift

class VoiceRecord: Object {
    
    @objc dynamic var title: String = "Record \(Date())"
    @objc dynamic var dateCreated: Date?
    @objc dynamic var lenght: String?
    
}
