//
//  ViewController.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import UIKit
import MathParser
import Charts

class ViewController: UIViewController, userEnteredNewFunction, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var formulasTableView: UITableView!
    @IBOutlet weak var slider: UISlider!
    

    // Instance variables
    var currentList = ListOfFunctions()    // Holds the list of user generated functions
    var sliderValue = Int()
    var deltaX = Double()
    
    // Empty array for chart
    var valuesForChart : [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign delegates to viewController
        formulasTableView.delegate = self
        formulasTableView.dataSource = self
        
        // Register custom cell 'integral cell'
        formulasTableView.register(UINib(nibName: "IntegralCell", bundle: nil), forCellReuseIdentifier: "customIntegralCell")
        
        // Slider initial config
        sliderConfig(value: 50, max: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = formulasTableView.dequeueReusableCell(withIdentifier: "customIntegralCell", for: indexPath) as! IntegralCell
        
        // Populate our custom cell properties
        cell.upperBoundLabel.text = String(currentList.list[indexPath.row].upperBound)
        cell.lowerBoundLabel.text = String(currentList.list[indexPath.row].lowerBound)
        cell.formulaLabel.text = currentList.list[indexPath.row].functionGiven
        
        return cell
    }
    
    // If the user selects a row (formula), then perform calculations for:
    //      area approximation
    //      values for Chart (line and bar)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set value of DeltaX for selected formula
        deltaX = calculateDeltaX(row: indexPath.row, rectangles: sliderValue)
        
        // Set formatted string for selected formula
        guard let stringForMathParser = currentList.list[indexPath.row].finalizedInputString else {
            print("Found nil")
            return
        }
        
        // Test
        print(calcRSandGraphValues(numberOfRectangles: sliderValue, parsedString: stringForMathParser))
    }
    
    // Sets the height of out tableview rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // Number of rows will be the size of our currentList.list[] size
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList.list.count
    }
    
    // Automatically configure table
    func configureTableView(){
        formulasTableView.rowHeight = UITableViewAutomaticDimension // Request tableview to use default value
        formulasTableView.estimatedRowHeight = 120.0                // Standard for average message
        
    }
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - Calculations
    
    // Calculate deltaX
    // *Note* deltaX is the width of each rectangle, therefore the general formula to calculate is
    // (upperBound - lowerBound) = range of our desired area
    // ➗ by rectangles (number of desired rectangles)
    func calculateDeltaX(row: Int, rectangles: Int) -> Double {
        let upperBound = Double(currentList.list[row].upperBound)
        let lowerBound = Double(currentList.list[row].lowerBound)
        let deltaX = ((upperBound - lowerBound) / Double(rectangles))
        
        return deltaX
    }
    
    // Calculates the RiemannSum using MidPoint method
    func calcRSandGraphValues(numberOfRectangles: Int, parsedString: String) -> Double {
        var area : Double = 0.0
        var position : Double = deltaX / 2.0
        
        // Reset to initial condition
        valuesForChart = []
        
        for _ in 0...numberOfRectangles - 1 {
            do {
                // MathParser evaluates with a variable 'x' in the user input
                let value = try parsedString.evaluate(["x": position])
                area += value * (deltaX)
                
                // Append value to array
                valuesForChart.append(value)
                
                // Update position
                position += deltaX
                
                
                
            } catch {
                print(error)
            }
        }
        return area
    }
    
    
    //---------------------------------------------------------------------------------------------------
    //MARK: - UISlider
    
    func sliderConfig(value: Int, max: Float){
        slider.value = Float(value)
        slider.maximumValue = Float(max)
        
        // Set min to atleast 1 rectangle
        slider.minimumValue = 1
        
        // Global sliderValue
        sliderValue = value
    }
    
    @IBAction func sliderPressed(_ sender: UISlider) {
        // Update Global sliderValue if user selected slider
        sliderValue = Int(sender.value)
        
    }
    
    //---------------------------------------------------------------------------------------------------
}

