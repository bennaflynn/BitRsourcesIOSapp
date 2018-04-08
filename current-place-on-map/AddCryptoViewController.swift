//
//  AddCryptoViewController.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-03-16.
//  Copyright © 2018 William French. All rights reserved.
//

import UIKit
import CoreData
import SQLite

class AddCryptoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbols.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symbols[row]
    }
    
    

    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var AmountEdit: UITextField!
    
    
    let symbols = ["BTC", "ETH", "XRP", "BCH", "LTC", "ADA", "NEO", "XLM", "EOS"]
    let names = ["Bitcoin", "Ethereum","Ripple", "Bitcoin Cash","Litecoin","Cardano","NEO","Stellar Lumens","EOS" ]
    
    @IBAction func AddCrypto(_ sender: Any) {
//        let context = self.getContext()
//        let CryptoEntity = NSEntityDescription.entity(forEntityName: "Crypto", in: context)
//        let insert = NSManagedObject(entity: CryptoEntity!, insertInto: context)
        
        let repo = CryptoRepo()
        
        if(AmountEdit.text != "") {
            var amount : Float = NSString(string: AmountEdit.text!).floatValue
            if(!amount.isNaN) {
                var symbol = symbols[picker.selectedRow(inComponent: 0)]
                var name = names[symbols.index(of: symbols[picker.selectedRow(inComponent: 0)])!]

                var cryptos = [Cryptos] ()
                cryptos = repo.All()
                
                
                
                for crypto in cryptos {
                    if(crypto.symbol == symbol) {
                        //crypto exists in the db so just update the row
                        
                        var newQty = crypto.qty + amount;
                        
                        //if the result is less than zero then delete the entry entirely
                        if(newQty < 0) {
                            repo.Delete(_id: crypto.id!)
                            return
                        }
                        
                        repo.Update(_id: crypto.id!, _name: crypto.name, _qty: newQty, _symbol: crypto.symbol)
                        return
                    }
                }
                //if the cryptos were looped through and the specific crypto hadn't been added then add it here
                repo.Insert(_name: name, _qty: amount, _symbol: symbol)
            }
        }
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "tableView") as! NetWorthController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.dataSource = self
        self.picker.delegate = self
        
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
