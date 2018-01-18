//
//  ViewController.swift
//  Counter
//
//  Created by Amir Sahabi  on 1/16/18.
//  Copyright © 2018 Amir Sahabi . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserValues()
        
        // set all labels to init vals on start up
        updateAllLabels()
        
        // set up gesture recognizer
        leftScreenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.continueToNextGeneration))
        leftScreenEdgeRecognizer.edges = .left
        
        rightScreenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.resetGames))
        rightScreenEdgeRecognizer.edges = .right
        
        view.addGestureRecognizer(leftScreenEdgeRecognizer)
        view.addGestureRecognizer(rightScreenEdgeRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUserValues() {
        if userDefaults.object(forKey: "terraformRating") != nil {
            terraformRating = userDefaults.integer(forKey: "terraformRating")
        } else {
            terraformRating = 20
        }
        moneyVal = userDefaults.integer(forKey: "moneyVal")
        if userDefaults.object(forKey: "moneyProductionVal") != nil {
            moneyProductionVal = userDefaults.integer(forKey: "moneyProductionVal")
        } else {
            moneyProductionVal = 1
        }
        plantsVal = userDefaults.integer(forKey: "plantsVal")
        if userDefaults.object(forKey: "plantProductionVal") != nil {
            plantProductionVal = userDefaults.integer(forKey: "plantProductionVal")
        } else {
            plantProductionVal = 1
        }
        steelVal = userDefaults.integer(forKey: "steelVal")
        if userDefaults.object(forKey: "steelProductionVal") != nil {
            steelProductionVal = userDefaults.integer(forKey: "steelProductionVal")
        } else {
            steelProductionVal = 1
        }
        energyVal = userDefaults.integer(forKey: "energyVal")
        if userDefaults.object(forKey: "energyProductionVal") != nil {
            energyProductionVal = userDefaults.integer(forKey: "energyProductionVal")
        } else {
            energyProductionVal = 1
        }
        titaniumVal = userDefaults.integer(forKey: "titaniumVal")
        if userDefaults.object(forKey: "titaniumProductionVal") != nil {
            titaniumProductionVal = userDefaults.integer(forKey: "titaniumProductionVal")
        } else {
            titaniumProductionVal = 1
        }
        heatVal = userDefaults.integer(forKey: "heatVal")
        if userDefaults.object(forKey: "heatProductionVal") != nil {
            heatProductionVal = userDefaults.integer(forKey: "heatProductionVal")
        } else {
            heatProductionVal = 1
        }
    }
    
    func saveUserValues() {
        userDefaults.set(terraformRating, forKey: "terraformRating")
        userDefaults.set(moneyVal, forKey: "moneyVal")
        userDefaults.set(moneyProductionVal, forKey: "moneyProductionVal")
        userDefaults.set(plantsVal, forKey: "plantsVal")
        userDefaults.set(plantProductionVal, forKey: "plantProductionVal")
        userDefaults.set(steelVal, forKey: "steelVal")
        userDefaults.set(steelProductionVal, forKey: "steelProductionVal")
        userDefaults.set(energyVal, forKey: "energyVal")
        userDefaults.set(energyProductionVal, forKey: "energyProductionVal")
        userDefaults.set(titaniumVal, forKey: "titaniumVal")
        userDefaults.set(titaniumProductionVal, forKey: "titaniumProductionVal")
        userDefaults.set(heatVal, forKey: "heatVal")
        userDefaults.set(heatProductionVal, forKey: "heatProductionVal")
    }
    
    func resetGames(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            let alert = UIAlertController(title: "Reset Game?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                self.terraformRating = 20
                
                self.moneyVal = 0
                self.plantsVal = 0
                self.steelVal = 0
                self.energyVal = 0
                self.titaniumVal = 0
                self.heatVal = 0
                
                self.moneyProductionVal = 1
                self.plantProductionVal = 1
                self.steelProductionVal = 1
                self.energyProductionVal = 1
                self.titaniumProductionVal = 1
                self.heatProductionVal = 1
                
                self.updateAllLabels()
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func continueToNextGeneration(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            let alert = UIAlertController(title: "Continue to next generation?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                self.calculateNextGeneration()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func calculateNextGeneration() {
        moneyVal += moneyProductionVal + terraformRating
        plantsVal += plantProductionVal
        steelVal += steelProductionVal
        titaniumVal += titaniumProductionVal
        heatVal += heatProductionVal + energyVal
        energyVal = energyProductionVal
        updateAllLabels()
    }
    
    func updateAllLabels() {
        // resources
        moneyButton.setAttributedTitle(createAttributedText(value: moneyVal, size: resourceFontSize), for: UIControlState.normal)
        plantsButton.setAttributedTitle(createAttributedText(value: plantsVal, size: resourceFontSize), for: UIControlState.normal)
        steelButton.setAttributedTitle(createAttributedText(value: steelVal, size: resourceFontSize), for: UIControlState.normal)
        energyButton.setAttributedTitle(createAttributedText(value: energyVal, size: resourceFontSize), for: UIControlState.normal)
        titaniumButton.setAttributedTitle(createAttributedText(value: titaniumVal, size: resourceFontSize), for: UIControlState.normal)
        heatButton.setAttributedTitle(createAttributedText(value: heatVal, size: resourceFontSize), for: UIControlState.normal)
        
        // production tracks
        moneyProductionButton.setAttributedTitle(createAttributedText(value: moneyProductionVal, size: productionFontSize), for: UIControlState.normal)
        plantProductionButton.setAttributedTitle(createAttributedText(value: plantProductionVal, size: productionFontSize), for: UIControlState.normal)
        steelProductionButton.setAttributedTitle(createAttributedText(value: steelProductionVal, size: productionFontSize), for: UIControlState.normal)
        energyProductionButton.setAttributedTitle(createAttributedText(value: energyProductionVal, size: productionFontSize), for: UIControlState.normal)
        titaniumProductionButton.setAttributedTitle(createAttributedText(value: titaniumProductionVal, size: productionFontSize), for: UIControlState.normal)
        heatProductionButton.setAttributedTitle(createAttributedText(value: heatProductionVal, size: productionFontSize), for: UIControlState.normal)
        terraformRatingButton.setAttributedTitle(createAttributedText(value: terraformRating, size: productionFontSize), for: .normal)
        
        moneyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        moneyProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        plantsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        plantProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        steelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        steelProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        energyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        energyProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        titaniumButton.titleLabel?.adjustsFontSizeToFitWidth = true
        titaniumProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        heatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        heatProductionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        terraformRatingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        saveUserValues()
    }
    
    func createAttributedText(value: Int, size: CGFloat) -> NSAttributedString {
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeWidthAttributeName : -4.0,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: size)
            ] as [String : Any]
        
        return NSAttributedString(string: String(value), attributes: strokeTextAttributes)
    }
    
    /* 
        i know what you're thinking, this looks ridiculous
        but blame xcode for not letting me connect existing
        actions to any other elements
     */
    @IBAction func terraformRatingSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func meResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func meProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func plantResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func plantProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func steelResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func steelProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func energyResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func energyProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func titaniumResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func titaniumProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func heatResourceSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func heatProductionSent(_ sender: Any) {
        resourceWasTouched(sender:sender)
    }
    @IBAction func convertPlants(_ sender: Any) {
        if plantsVal >= 8 {
            presentConvert8ResourceAlert(resource:"Plants") }
        else {
            presentErrorAlert(resource: "Plants")
        }
    }
    
    @IBAction func convertHeat(_ sender: Any) {
        print("here")
        if heatVal >= 8 {
            presentConvert8ResourceAlert(resource: "Heat")
        } else {
            presentErrorAlert(resource:"Heat")
        }
    }
    
    func presentErrorAlert(resource: String) {
        let alert = UIAlertController(title: "Not enough " + resource + " to convert", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

        present(alert, animated: true, completion: nil)

    }
    
    func presentConvert8ResourceAlert(resource:String) {
        let alert = UIAlertController(title: "Convert 8 " + resource + "?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            if resource == "Plants" {
                self.plantsVal -= 8
            } else if resource == "Heat" {
                self.heatVal -= 8
            }
            self.updateAllLabels()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
    func resourceWasTouched(_ sender: Any) {
        let button = sender as! UIButton
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopOver") as! PopoverController
        vc.modalPresentationStyle = .popover
        vc.resourceName = button.title(for: .normal)!
        vc.resourceValue = Int((button.currentAttributedTitle?.string)!)!
        vc.originalObject = self
        
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = UIPopoverArrowDirection.any
        popover.sourceView = button
        present(vc, animated: true, completion: nil)
    }
    
    let userDefaults: UserDefaults = UserDefaults.standard
    let resourceFontSize = CGFloat(52)
    let productionFontSize = CGFloat(26)
    
    var leftScreenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var rightScreenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var terraformRating = 20
    
    var moneyVal = 0
    var plantsVal = 0
    var steelVal = 0
    var energyVal = 0
    var titaniumVal = 0
    var heatVal = 0
    
    var moneyProductionVal = 1
    var plantProductionVal = 1
    var steelProductionVal = 1
    var energyProductionVal = 1
    var titaniumProductionVal = 1
    var heatProductionVal = 1
    
    @IBOutlet weak var terraformRatingButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var plantsButton: UIButton!
    @IBOutlet weak var steelButton: UIButton!
    @IBOutlet weak var energyButton: UIButton!
    @IBOutlet weak var titaniumButton: UIButton!
    @IBOutlet weak var heatButton: UIButton!
    @IBOutlet weak var moneyProductionButton: UIButton!
    @IBOutlet weak var plantProductionButton: UIButton!
    @IBOutlet weak var steelProductionButton: UIButton!
    @IBOutlet weak var energyProductionButton: UIButton!
    @IBOutlet weak var titaniumProductionButton: UIButton!
    @IBOutlet weak var heatProductionButton: UIButton!
}

