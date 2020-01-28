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
    
    
    dynamic var title: String = "Record \(dateFormatMethod(date: Date()))"
    dynamic var fileName: String = "audioFile\(dateFormatMethod(date: Date())).m4a"
    var records = List<RecordModel>()

}

func dateFormatMethod(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd_HH:mm:ss"
    let dateString = formatter.string(from: Date.init())
    return dateString
}
