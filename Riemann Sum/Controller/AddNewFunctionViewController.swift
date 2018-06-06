//
//  AddNewFunctionViewController.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

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
        if let fnc = functionTextField.text {
            delegate?.dataRecieved(fn: fnc, upper: Int(upperBoundTextField.text!)!, lower: Int(lowerBoundTextField.text!)!)
        } else {
            print("Func not entered.")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Allow only these keyboard characters
    // Overrides our textField to only allows numbers, x, +, -, /, *, (, ), and -
    // Future update should include: sin(), cos(), tan(), arctan(), etc...
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"-0123456789x*+/e()$").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        return string == numberFiltered
    }
}
