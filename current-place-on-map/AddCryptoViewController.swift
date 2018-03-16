//
//  AddCryptoViewController.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-03-16.
//  Copyright © 2018 William French. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var pickerTextField : UITextField!
    
    let symbols = ["BTC", "ETH", "XRP", "BCH", "LTC", "ADA", "NEO", "XLM", "EOS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.dataSource = self
        self.picker.delegate = self
        
    }
    
}
