//
//  BalinskiYoungAlgorith.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 05/04/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import Cocoa

public struct BalinskiYoungAlgorith {
    
    /// **Algorytm dla problemu wyboru miejsc w parlamencie metodą Balińskiego i Younga**.
    ///
    /// * Wybiera się stan o największej wartości pi /(ai+1).
    /// * Jest monotoniczna ze względu na rozmiar parlamentu.
    /// * Zachowuje kwotę.
    ///
    /// - parameters:
    ///   - Array(Int): Tablica populacji stanów
    ///   - Int: Liczba miejsc w parlamencie
    /// - returns: 
    ///   - [Int]: Tablica rozmieszczenia miejsc w parlamencie dla stanów
    
    public static func count(populations:[Int], parliamentCount: Int) -> [Int] {
        let parliamentCount: Int = parliamentCount
        let populations:[Int] = populations
        let populationCount: Int = populations.reduce(0, combine: +)
        var a = [Int](count:populations.count, repeatedValue: 0)
        
        if parliamentCount == 0 {
            return a
        }
        
        for i in 1...parliamentCount {
            var tempQ = [Double]()
            
            for (index, element) in populations.enumerate() {
                let q: Double = Double(i) * Double(element) / Double(populationCount)
                
                if Double(a[index]) < q{
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
            if a.count == 0 {
                return a
            }
            a[maxQ.index] += 1
        }
        
        return a
    }
    
}
