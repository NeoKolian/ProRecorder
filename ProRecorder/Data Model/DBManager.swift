//
//  DBManager.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 16.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import Foundation
import RealmSwift

protocol DBManager {
    
    func save(record: RecordModel)
    
    func obtainRecords() -> [RecordModel]
    
    func deleteFromDB(object: RecordModel)
    
}

class DBManagerImpl: DBManager {
        
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)
    
    var myRecordModel = RecordModel()
    
    func save(record:RecordModel){
        myRecordModel.fileName = "audioFile\(Date()).m4a"
        myRecordModel.title = "Record \(Date())"
        
        try! mainRealm.write {
            mainRealm.add(record)
        }
    }
    
    func obtainRecords() -> [RecordModel] {
        let records = mainRealm.objects(RecordModel.self)
        
        return Array(records)
    }
    
    func deleteFromDB(object: RecordModel)   {
         try!   mainRealm.write {
            mainRealm.delete(object)
         }
     }
}
