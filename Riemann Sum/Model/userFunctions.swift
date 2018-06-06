//
//  userFunctions.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

class UserFunctions {
    var upperBound : Int = 0
    var lowerBound : Int = 0
    var functionGiven : String = ""
    var areaUnderCurve : Float?
    
    init(){
        
    }
    
    convenience init(upperBoundLimit: Int, lowerBoundLimit: Int, functionEntry: String){
        self.init()
        
        upperBound = upperBoundLimit
        lowerBound = lowerBoundLimit
        functionGiven = functionEntry
    }
    
}
