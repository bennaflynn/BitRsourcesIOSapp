//
//  Crypto.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-04-05.
//  Copyright © 2018 William French. All rights reserved.
//

//import Foundation

class Cryptos {
    let id: Int64?
    var name: String
    var qty: Float
    var symbol: String
    init(id:Int64, name:String,qty:Float,symbol:String) {
        self.id = id
        self.name = name
        self.qty = qty
        self.symbol = symbol
    }
}
