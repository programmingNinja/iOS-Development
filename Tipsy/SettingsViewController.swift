//
//  SettingsViewController.swift
//  Tipsy
//
//  Created by Rohan Shah on 9/2/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defSwitch: UISwitch!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
