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
    
//    func obtainRecords() -> [RecordsStore]
    
    func deleteFromDB(object: RecordModel)
    
}

class DBManagerImpl: DBManager {
        
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)
    
    func save(record:RecordModel){
        
        try! mainRealm.write {
            mainRealm.add(record)
        }
    }
    
//    func obtainRecords() -> [RecordsStore] {
//        let records = mainRealm.objects(RecordsStore.self)
//
//        return Array(records)
//    }
    
    func deleteFromDB(object: RecordModel)   {
         try!   mainRealm.write {
            mainRealm.delete(object)
         }
     }
}
