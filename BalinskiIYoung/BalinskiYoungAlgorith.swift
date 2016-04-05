//
//  BalinskiYoungAlgorith.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 05/04/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import Cocoa

public struct BalinskiYoungAlgorith {
    
    public static func count(populations:[Double], parliamentCount: Double) -> [Double] {
        let parliamentCount: Double = parliamentCount
        let populations:[Double] = populations
        let populationCount: Double = populations.reduce(0, combine: +)
        var a = [Double](count:populations.count, repeatedValue: 0.0)
        
        
        for (var i:Double=1.0; i<=parliamentCount; i += 1) {
            
            var tempQ = [Double]()
            
            for (index, element) in populations.enumerate() {
                let q: Double = i*element/populationCount
                
                
                if a[index] < q{
                    tempQ.append(q)
                } else {
                    tempQ.append(0.0)
                }
            }
            
            var maxQ = (value:0.0, index:0)
            
            for (index, value) in tempQ.enumerate() {
                if value > maxQ.value {
                    maxQ = (value: value, index: index)
                }
            }
            
            a[maxQ.index] += 1
        }
        
        return a
    }
    
}
