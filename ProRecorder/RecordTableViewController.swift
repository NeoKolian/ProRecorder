//
//  RecordTableViewController.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 17.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class RecordTableViewController: UITableViewController {
    
    var myDBManager: DBManager = DBManagerImpl()
    var tableRecord: Results<RecordModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        fetchData()
        
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let obtain = myDBManager.obtainRecords()
        
        return obtain.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! SwipeTableViewCell
        let title = tableRecord?[indexPath.row]
        cell.textLabel?.text = title?.title
        
        cell.delegate = self

        return cell
    }
    
    func fetchData() {
        let realm = try! Realm()
        
        tableRecord = realm.objects(RecordModel.self)
    }
}

extension RecordTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
         
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("item deleted")
            if let record = self.tableRecord?[indexPath.row] {
                self.myDBManager.deleteFromDB(object: record)
            }
            else {
                print("Error deleting item")
            }
        }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
