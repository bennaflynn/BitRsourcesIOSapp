//
//  AddCryptoViewController.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-03-16.
//  Copyright © 2018 William French. All rights reserved.
//

import UIKit
import CoreData

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
        let context = self.getContext()
        let CryptoEntity = NSEntityDescription.entity(forEntityName: "Crypto", in: context)
        let insert = NSManagedObject(entity: CryptoEntity!, insertInto: context)
        if(AmountEdit.text != "") {
            var amount : Float = NSString(string: AmountEdit.text!).floatValue
            if(!amount.isNaN) {
                var symbol = symbols[picker.selectedRow(inComponent: 0)]
                var name = names[picker.selectedRow(inComponent: 0)]
                insert.setValue(name, forKey: "name")
                insert.setValue(amount, forKey: "qty")
                insert.setValue(symbol, forKey: "symbol")
                
                do {
                    try context.save()
                } catch {
                    
                }
            }
        }
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
