//
//  ViewController.swift
//  Tipsy
//
//  Created by Rohan Shah on 9/1/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountText: UITextField!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentagesSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
        self.billAmountText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditBillAmount(sender: AnyObject) {
        if billAmountText.hasText() {
            println("typing")
            var amount = (billAmountText.text as NSString).doubleValue
            var tip = 0.15*amount
            var total = tip+amount
            
            tipAmountLabel.text = String(format: "$%.2f", tip)
            totalAmountLabel.text = String(format: "$%.2f", total)
            
        }
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onChange(sender: AnyObject) {
        var tipPercentage = [0.15 , 0.2 , 0.25]
        var rate = tipPercentage[tipPercentagesSegment.selectedSegmentIndex]
        var amount = (billAmountText.text as NSString).doubleValue
        var tip = rate * amount
        var total = tip + amount
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalAmountLabel.text = String(format: "$%.2f", total)

    }
}

