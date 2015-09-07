//
//  SettingsViewController.swift
//  Tipsy
//
//  Created by Rohan Shah on 9/2/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipLabel: UILabel!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Settings did load")
        defaults.setFloat(defaults.floatForKey("defaultTipPerc"), forKey: "defaultTipPerc")
        defaults.setBool(defaults.boolForKey("useDef"), forKey: "useDef")
        defaults.synchronize()
        
        tipSlider.value = defaults.floatForKey("defaultTipPerc")
        var sliderValue = Int(tipSlider.value)
        tipLabel.text = "\(sliderValue)%"
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSliderChanged(sender: UISlider) {
        var sliderValue = Int(sender.value)
        tipLabel.text = "\(sliderValue)%"
        defaults.setInteger(sliderValue, forKey: "defaultTipPerc")
        defaults.synchronize()
        let backColor = CGFloat(sender.value)
        if (tipSlider.value >= 0 && tipSlider.value <= 15) {
            self.view.backgroundColor = UIColor(red: 255.0/255, green:(backColor*17)/255, blue:0, alpha:0.6)
        }
        if tipSlider.value > 15 && tipSlider.value <= 30 {
            self.view.backgroundColor = UIColor(red: (255.0-((backColor-15.0)*17.0))/255.0, green:255.0/255, blue:0, alpha:0.6)
            
        } else if tipSlider.value > 30 && tipSlider.value <= 70 {
            self.view.backgroundColor = UIColor(red: (((backColor/4.67)*17.0)/255), green:(255.0/255), blue:0, alpha:0.6)
        } else {
            self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (255.0-((backColor+155.0)/255.0)), blue: 0, alpha:0.6)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
