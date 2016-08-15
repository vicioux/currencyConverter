//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppModel.sharedInstance.getCurrencies { (fail) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let currencies = AppModel.sharedInstance.currencies {
            return currencies.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)
        
        if let currencies = AppModel.sharedInstance.currencies {
            cell.textLabel?.text = currencies[indexPath.row].getCurrencyConversion(200)
        }

        return cell
    }
    
}

