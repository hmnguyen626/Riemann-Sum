//
//  AddNewFunctionViewController.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

// Every delegate must conform to this protocol
protocol userEnteredNewFunction{
    func dataRecieved(fn: String, upper: Int, lower: Int)
    
}

class AddNewFunctionViewController: UIViewController, UITextFieldDelegate {
    // Our delegate
    var delegate : userEnteredNewFunction?
    
    // Outlets
    @IBOutlet weak var functionTextField: UITextField!
    @IBOutlet weak var upperBoundTextField: UITextField!
    @IBOutlet weak var lowerBoundTextField: UITextField!
    @IBOutlet weak var yAlignmentConstraint: NSLayoutConstraint!
    @IBOutlet weak var popUpView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        self.functionTextField.delegate = self
        self.upperBoundTextField.delegate = self
        self.lowerBoundTextField.delegate = self
        
        // Rounded corners for popUpView
        popUpView.layer.cornerRadius = 15
        // Anything that is above it, it conforms to what shape the main view has
        popUpView.layer.masksToBounds = true
        
        // Set keyboard to numpad
        self.upperBoundTextField.keyboardType = UIKeyboardType.decimalPad
        self.lowerBoundTextField.keyboardType = UIKeyboardType.decimalPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //---------------------------------------------------------------------------------------------------
    //MARK: - Textfield functionalities
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            // Shift our alignment up so there is space for our keyboard
            self.yAlignmentConstraint.constant = -100
            
            // If needed
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        UIView.animate(withDuration: 0.5) {
            // Shift our alignment up so there is space for our keyboard
            self.yAlignmentConstraint.constant = -80
            
            // If needed
            self.view.layoutIfNeeded()
        }
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Buttons pressed
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        // If input is valid then send data backwards to our delegate, and dismiss this viewcontroller
        if validInput(){
            delegate?.dataRecieved(fn: functionTextField.text!, upper: Int(upperBoundTextField.text!)!, lower: Int(lowerBoundTextField.text!)!)
            
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Not all inputs are present.")
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Keyboard and character checks
    
    // Dismisses keyboard if touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Error Checking: Ensure that all parameters for user input is valid
    func validInput() -> Bool {
        if functionTextField.text == "" || upperBoundTextField.text == "" || lowerBoundTextField.text == "" {
            return false
        } else {
            return true
        }
    }
    
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Allow only these keyboard characters
    // Overrides our textField to only allows numbers, x, +, -, /, *, (, ), and -
    // Future update should include: sin(), cos(), tan(), arctan(), etc...
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"-0123456789x*+/e()$cositan").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        return string == numberFiltered
    }
}
