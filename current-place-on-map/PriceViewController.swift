//
//  PriceViewController.swift
//  current-place-on-map
//
//  Created by Ben Flynn on 2018-04-08.
//  Copyright © 2018 William French. All rights reserved.
//

import UIKit
import SwiftyJSON

class PriceViewController: UIViewController {
    
    var symbol: String = ""
    var price: String = ""
    var name: String = ""
    var qty: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBAction func goBackToTable(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(symbol)
        
        nameLabel.text = name
        qtyLabel.text = qty
        // Do any additional setup after loading the view.
        
        
        let group = DispatchGroup()
        group.enter()
//        DispatchQueue.main.async {
//            self.getPriceData(_url: "https://api.coinmarketcap.com/v1/ticker/?limit=15")
//            group.leave()
//        }
        DispatchQueue.main.async {
            self.getPriceData(_url: "https://api.coinmarketcap.com/v1/ticker/?limit=15", group: group)
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.priceLabel.text = String(format: "$%.02f", Double(self.price)! )
            let theValue = Double(Float(self.price)! * Float(self.qty)!)
            self.valueLabel.text = String(format: "$%.02f", theValue)
        }
      
        
        
    
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPriceData(_url:String, group: DispatchGroup) {
        let myUrl   = NSURL(string: _url);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET"
        
       
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // Convert data to json.
            let json = JSON(data!)
            
            for item in json.array! {
                print(String (describing: item["name"]))
                if(String(describing: item["symbol"]) == self.symbol) {
                    self.price = String(describing: item["price_usd"])
                    print(self.price)
                    group.leave()
                }
            }
            
            
        }
        task.resume()
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
