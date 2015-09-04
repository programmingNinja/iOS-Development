//
//  ViewController.swift
//  Tipsy
//
//  Created by Rohan Shah on 9/1/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var billAmountText: UITextField!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentagesSegment: UISegmentedControl!
    var DestViewController : SettingsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
        self.billAmountText.becomeFirstResponder()
        println("Did Load")
        
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
        var defaults = NSUserDefaults.standardUserDefaults()
        var defTipPerc = defaults.integerForKey("defaultTipPerc")
        var defPerc:Double=(Double(defTipPerc)/100)
        var tipPercentage = [0.15 , 0.2 , 0.25, defPerc]
        var rate = tipPercentage[tipPercentagesSegment.selectedSegmentIndex]
        var amount = (billAmountText.text as NSString).doubleValue
        var tip = rate * amount
        var total = tip + amount
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalAmountLabel.text = String(format: "$%.2f", total)

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using 
       DestViewController = segue.destinationViewController as! SettingsViewController
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        var defaults = NSUserDefaults.standardUserDefaults()
        var defTipPerc = defaults.integerForKey("defaultTipPerc")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }

}

