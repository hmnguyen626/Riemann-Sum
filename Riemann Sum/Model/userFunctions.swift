//
//  userFunctions.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

class UserFunction {
    var upperBound : Int = 0
    var lowerBound : Int = 0
    var functionGiven : String = ""
    var finalizedInputString : String?
    
    init(){
        
    }
    
    convenience init(upperBoundLimit: Int, lowerBoundLimit: Int, functionEntry: String){
        self.init()
        
        upperBound = upperBoundLimit
        lowerBound = lowerBoundLimit
        functionGiven = functionEntry
        formatForParser()
    }
    
    func calculateValuesForGraph(){
        
    }
    
    // Returns a formatted string to be passed to MathParser
    func formatForParser() {
        // Placeholders
        let array = Array(functionGiven)
        var convertedString : String = ""
        var newArray = [Character]()
        
        // Loops through array looking for variable x
        for i in 0...(array.count - 1) {
            if array[i] == "x" {
                newArray.append("$")
                newArray.append(array[i])
                
            } else {
                newArray.append(array[i])
            }
        }
        
        // Assign place holder to newly converted character array
        convertedString = String(newArray)
        
        // Set our optional string to a string that can be read by the MathParser
        finalizedInputString = convertedString
    }
}
