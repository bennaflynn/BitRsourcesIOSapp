//
//  CryptoRepo.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-04-05.
//  Copyright © 2018 William French. All rights reserved.
//

import SQLite

class CryptoRepo {
    var _db:OpaquePointer
    
    // Constructor
    init() {
        let dbService =  DBService()
        _db = dbService.getConnection()
    }
    
    // Insert row of contacts.
    func Insert(_name:String, _qty:Float, _symbol: String) {
        
        // Create re-useable query. We can populate the
        // question mark values when needed.
        let queryString
            = "INSERT INTO Crypto (name, qty, symbol) VALUES ('\(_name)',\(_qty),'\(_symbol)')"
        
        // Declare a statement
        var stmt: OpaquePointer?
        
        // sqlite3_prepare stores the statement as byte code.
        if sqlite3_prepare(_db, queryString, -1, &stmt, nil)
            != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // Column 0 is the autogenerated primary key.
        
        // Bind column 1 which is firstName to byte code.
//        if sqlite3_bind_text(stmt, 1, _name, -1, nil)
//            != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(_db)!)
//            print("failure binding firstName: \(errmsg)")
//            return
//        }
//
//        // Bind column 2 which is phone to byte code.
//        if sqlite3_bind_double(stmt, 2, Double(Float32(_qty)))
//            != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(_db)!)
//            print("failure binding phone: \(errmsg)")
//            return
//        }
//
//        if sqlite3_bind_text(stmt, 3, _symbol, -1, nil)
//            != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(_db)!)
//            print("failure binding firstName: \(errmsg)")
//            return
//        }
        
        // Execute the query to insert values.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("failure inserting: \(errmsg)")
            return
        }
        
        // Delete statement to avoid resource leaks.
        sqlite3_finalize(stmt)
    }
    
    func Update(_id:Int64, _name:String, _qty: Float, _symbol: String) {
        let queryString = "UPDATE Crypto SET name = '\(_name)', qty = '\(_qty)', symbol = '\(_symbol)' WHERE id = '\(_id)'"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(_db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("failure inserting: \(errmsg)")
            return
        }
        print("Updating")
        print(queryString)
        sqlite3_finalize(stmt)
    }
    
    func Delete(_id:Int64) {
        let queryString = "DELETE FROM Crypto WHERE id = '\(_id)'"
        
        var stmt: OpaquePointer?
        
        if(sqlite3_prepare(_db, queryString, -1, &stmt, nil) != SQLITE_OK) {
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("error preparing DELETE: \(errmsg)")
            return
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("failure DELETING: \(errmsg)")
            return
        }
        
        print(queryString)
        sqlite3_finalize(stmt)
    }
    
    // Get arry of contacts.
    func All()->[Cryptos] {
        
        // Declare array.
        var cryptoList = [Cryptos]()
        
        // First empty the list.
        cryptoList.removeAll()
        
        // This is our select query.
        let queryString = "SELECT * FROM Crypto"
        
        // Statement pointer.
        var stmt:OpaquePointer?
        
        // Convert query to byte code.
        if sqlite3_prepare(_db, queryString, -1, &stmt, nil)
            != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(_db)!)
            print("error preparing insert: \(errmsg)")
            //   return
        }
        
        // Iterate through all rows.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            // Extract the values.
            let id = sqlite3_column_int(stmt, 0)
            let name
                = String(cString: sqlite3_column_text(stmt, 1))
            let qty = sqlite3_column_double(stmt, 2)
            let symbol = String(cString: sqlite3_column_text(stmt,3))
            
            // Add values to list.
            cryptoList.append(Cryptos(id: Int64(id),
                                       name: name,
                                       qty: Float(qty),
                                       symbol:symbol))
        }
        
        // Delete statement to avoid resource leaks.
        sqlite3_finalize(stmt)
        return cryptoList
    }
}
