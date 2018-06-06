//
//  ViewController.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, userEnteredNewFunction {
    
    // Instance variables
    var currentList = ListOfFunctions()    // Holds the list of user generated functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func newButtonPressed(_ sender: UIButton) {
        // Go to AddNewFunctionViewController
        performSegue(withIdentifier: "goToAddNew", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddNew" {
            let destinationVC = segue.destination as! AddNewFunctionViewController
            
            // Set the delegate as current VC
            destinationVC.delegate = self
        }
    }
    
    func dataRecieved(fn: String, upper: Int, lower: Int) {
        // Create a new entry from the data recieved.
        let entry = UserFunction(upperBoundLimit: upper, lowerBoundLimit: lower, functionEntry: fn)
        
        // Append to our list of userFunction objects array.
        currentList.list.append(entry)
        
        // Testing
        currentList.printDetailsAtIndex(indexAt: 0)
        //print(entry.functionGiven)
    }
}

