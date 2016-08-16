//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private struct Identifier
    {
        static let currencyTableViewCell = "CurrencyTableViewCell"
    }
    
    @IBOutlet weak var currencyTextField: UITextField! {
        didSet {
            currencyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        }
    }
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    var fieldNumber :Int = 0

    //hardcode variable god forgiveme.
    var animationSwowed = [Bool](count: 4, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppModel.sharedInstance.getCurrencies { (fail) in
            if (fail != nil) {
                print(fail.description)
            }
        }
        
        let currencyTableNib = UINib(nibName: Identifier.currencyTableViewCell, bundle: nil)
        self.currencyTableView.registerNib(currencyTableNib, forCellReuseIdentifier: Identifier.currencyTableViewCell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidChange(textField: UITextField) {
        let currentText = textField.text!
        let value = Int(currentText) ?? 0
        fieldNumber = value
        currencyTableView.reloadData()
    }
    
}

/* UITextFieldDelegate */
extension MainViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = currencyTextField.text!
        let isDeleting = range.length == 1 && string.isEmpty
        let newLength = currentText.length + string.length - range.length
        let isWriting = !isDeleting
        
        if !string.isNumeric && isWriting {
            return false
        }
        
        return newLength <= 9
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
        
        let cell: CurrencyTableViewCell = tableView.dequeueReusableCellWithIdentifier(Identifier.currencyTableViewCell) as! CurrencyTableViewCell
        guard  let currencies = AppModel.sharedInstance.currencies else { return cell }
        cell.currency = currencies[indexPath.row].getCurrencyConversion(fieldNumber)

        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if animationSwowed[indexPath.row] == false {
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0) {
                cell.layer.transform = CATransform3DIdentity
            }
            
            animationSwowed[indexPath.row] = true
        }
        
    }
    
}

