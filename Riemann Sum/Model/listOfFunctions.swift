//
//  listOfFunctions.swift
//  Riemann Sum
//
//  Created by Hieu Nguyen on 6/5/18.
//  Copyright © 2018 HMdev. All rights reserved.
//

import Foundation

class ListOfFunctions {
    var list : [UserFunction] = [UserFunction]()
    
    init(){

    }
    
    func printDetailsAtIndex(indexAt: Int){
        print(list[indexAt].functionGiven)
    }
    
}
