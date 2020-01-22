//
//  VoiceRecord.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 14.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class RecordModel: Object {
   
    dynamic var title: String = "Record \(Date())"
    dynamic var fileName: String = "audioFile\(Date()).m4a"
    var records = List<RecordModel>()

}
