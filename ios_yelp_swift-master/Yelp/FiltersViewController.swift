//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Rohan Shah on 9/22/15.
//  Copyright (c) 2015 Rohan Shah. All rights reserved.
//

import UIKit


@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController:FiltersViewController, didUpdateFilters filters:[String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    
    //@IBOutlet weak var sortByPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    var sort = ["Best Matched", "Distance", "Highest Rated"]
    var categories:[[String: String]]!
    var deals = true
    var switchCategoryStates = [Int: Bool]()
    weak var delegate: FiltersViewControllerDelegate?
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        categories = yelpCategories()
        //sortByPicker.dataSource = self
        //sortByPicker.delegate = self
        /*defaults.setBool(defaults.boolForKey("dealsVal"), forKey:"dealsVal")
        defaults.setObject(defaults.objectForKey("categoryVal"), forKey:"categoryVal")
        defaults.synchronize()
        deals = defaults.boolForKey("dealsVal")
        categories = defaults.objectForKey("categoryVal") as! [[String:String]]!*/
        self.tableView.reloadData()
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var filters = [String: AnyObject]()
        
        var selectCategories = [String]()
        for(row,isSelected) in switchCategoryStates {
            if isSelected {
                selectCategories.append(categories[row]["code"]!)
            }
        }
        
        if selectCategories.count > 0 {
            filters["categories"] = selectCategories
            //defaults.setObject(selectCategories, forKey: "categoryVal")
        }
        
        filters["deals"] = self.deals
        filters["sort"] = 0//sortByPicker.selectedRowInComponent(0)
        //defaults.setBool(self.deals, forKey: "dealsVal")
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    func yelpCategories() -> [[String: String]]{
        
        var categories = Categories()
        return categories.list
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 1
        case 1:
            return categories.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        
        if(indexPath.section == 1) {
            let cuisineName = self.categories[indexPath.row]["name"]
            
            cell.switchLabel.text = cuisineName
        }
        
        if(indexPath.section == 0) {
            cell.switchLabel.text = "Deals Only: "
        }
        
        cell.delegate = self
        
        if (indexPath.section == 1) {
            cell.onSwitch.on = switchCategoryStates[indexPath.row] ?? false
        } else if (indexPath.section == 1) {
            cell.onSwitch.on = self.deals
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(section == 1) {
            return "Cuisine"
        }
        
        if(section == 0) {
            return "Deals"
        }
        
        return "Others"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    /*func numberOfComponentsInPickerView(sortByPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(sortByPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sort.count
    }
    
    func pickerView(sortByPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return sort[row]
    }*/
    
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        println("Value changed from view controller")
        
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        if(indexPath.section == 1) {
            switchCategoryStates[indexPath.row] = value
        } else if (indexPath.section == 0) {
            self.deals = value
            println(self.deals)
        }
        
        println(switchCategoryStates)
        println(self.deals)
        
    }
}
