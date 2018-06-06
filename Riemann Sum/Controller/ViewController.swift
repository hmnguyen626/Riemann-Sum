//
//  ViewController.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, userEnteredNewFunction, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var formulasTableView: UITableView!
    
    
    
    // Instance variables
    var currentList = ListOfFunctions()    // Holds the list of user generated functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign delegates to viewController
        formulasTableView.delegate = self
        formulasTableView.dataSource = self
        
        // Register custom cell 'integral cell'
        formulasTableView.register(UINib(nibName: "Integral Cell", bundle: nil), forCellReuseIdentifier: "customIntegralCell")
        
    }

    //---------------------------------------------------------------------------------------------------
    //MARK: - segue to goToAddNew

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
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - dataRecieved from protocol
    
    func dataRecieved(fn: String, upper: Int, lower: Int) {
        // Create a new entry from the data recieved.
        let entry = UserFunction(upperBoundLimit: upper, lowerBoundLimit: lower, functionEntry: fn)
        
        // Append to our list of userFunction objects array.
        currentList.list.append(entry)
        
        // Set tableView config
        configureTableView()
        
        // Reload our tableView data
        formulasTableView.reloadData()
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - UITABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Copied identifier from custom class identifier value 'customIntegralCell'
        // indexPath refers to the location of the cell, etc row1,row2,row3
        // Because we are using a custom cell, we must cast it as the custom class "Integral_Cell"
        let cell = formulasTableView.dequeueReusableCell(withIdentifier: "customIntegralCell", for: indexPath) as! Integral_Cell
        
        cell.topBoundLabel.text = String(currentList.list[indexPath.row].upperBound)
        cell.bottomBoundLabel.text = String(currentList.list[indexPath.row].lowerBound)
        cell.formulaLabel.text = currentList.list[indexPath.row].functionGiven
        
        return cell
    }
    
    // Number of rows will be the size of our currentList.list[] size
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList.list.count
    }
    
    func configureTableView(){
        formulasTableView.rowHeight = UITableViewAutomaticDimension // Request tableview to use default value
        formulasTableView.estimatedRowHeight = 120.0                // Standard for average message
        
    }
    
    //---------------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

