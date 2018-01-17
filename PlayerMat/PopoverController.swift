//
//  PopoverController.swift
//  Counter
//
//  Created by Amir Sahabi  on 1/16/18.
//  Copyright © 2018 Amir Sahabi . All rights reserved.
//

import UIKit

class PopoverController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateLabels() {
        headerLabel.title = resourceName
        resourceValueLabel.text = String(resourceValue)
    }
    
    func alertUser(message: String) {
        let alert = UIAlertController(title: "Unavailable Resources", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelOutOfPopover() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissPopoverAndSave() {
        if originalObject != nil {
            // we can save and update
            switch resourceName {
            case "M€":
                originalObject?.moneyVal = resourceValue
                break
            case "M€ Production":
                originalObject?.moneyProductionVal = resourceValue
                break
            case "Plants":
                originalObject?.plantsVal = resourceValue
                break
            case "Plant Production":
                originalObject?.plantProductionVal = resourceValue
                break
            case "Steel":
                originalObject?.steelVal = resourceValue
                break
            case "Steel Production":
                originalObject?.steelProductionVal = resourceValue
                break
            case "Energy":
                originalObject?.energyVal = resourceValue
                break
            case "Energy Production":
                originalObject?.energyProductionVal = resourceValue
                break
            case "Titanium":
                originalObject?.titaniumVal = resourceValue
                break
            case "Titanium Production":
                originalObject?.titaniumProductionVal = resourceValue
                break
            case "Heat":
                originalObject?.heatVal = resourceValue
                break
            case "Heat Production":
                originalObject?.heatProductionVal = resourceValue
                break
            case "Terraform Rating":
                originalObject?.terraformRating = resourceValue
                break
            default:
                break
            }
            originalObject?.updateAllLabels()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func incrementResourceValue(_ sender: Any) {
        resourceValue += 1
        updateLabels()
    }
    @IBAction func incrementResourceByFive(_ sender: Any) {
        resourceValue += 5
        updateLabels()
    }
    @IBAction func decrementResourceValue(_ sender: Any) {
        var bottomLine = 0
        if resourceName == "M€ Production" {
            bottomLine = -5
        }
        
        if resourceValue - 1 < bottomLine {
            alertUser(message: "Could not decrement by 1 with only " + String(resourceValue) + " " + resourceName + " available")
        } else {
            resourceValue -= 1
            updateLabels()
        }
    }
    @IBAction func decrementResourceByFive(_ sender: Any) {
        var bottomLine = 0
        if resourceName == "M€ Production" {
            bottomLine = -5
        }
        
        if resourceValue - 5 < bottomLine {
            alertUser(message: "Could not decrement by 5 with only " + String(resourceValue) + " " + resourceName + " available")
        } else {
            resourceValue -= 5
            updateLabels()
        }
    }
    
    var resourceName = ""
    var resourceValue = 0
    var originalObject: ViewController? = nil
    
    @IBOutlet weak var resourceValueLabel: UILabel!
    @IBOutlet weak var headerLabel: UINavigationItem!
}
