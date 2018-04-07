//
//  DBService.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-04-05.
//  Copyright © 2018 William French. All rights reserved.
//

import Foundation
import SQLite

class DBService {
    let DBNAME = "cryptos.db"
    
    init() {
        self.CreateTable()
    }
    
    func getConnection() -> OpaquePointer {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DBNAME)
        
        var db: OpaquePointer?
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else {
            print(fileURL.path)
            
            /*
             // These instructions can be used to delete database
             let fm = FileManager.default
             do {
             try fm.removeItem(at:fileURL)
             } catch {
             NSLog("Error deleting file: \(fileURL)")
             }
             */
            return db!
        }
        return db!
    }
    
    // Create 'Contact' table if it does not exist.
    func CreateTable() {
        var db: OpaquePointer?
        db = self.getConnection()
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Crypto (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, qty FLOAT, symbol TEXT)", nil, nil, nil) != SQLITE_OK {
            
            // Extract error message with sqlite3_errmsg().
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
}
