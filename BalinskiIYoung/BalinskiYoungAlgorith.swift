//
//  BalinskiYoungAlgorith.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 05/04/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import Cocoa

public struct BalinskiYoungAlgorith {
    
    
    /// Algorytm dla problemu wyboru miejsc w parlamencie metodą Balińskiego i Younga.
    ///
    /// Leave a blank line to separate further text into paragraphs.
    ///
    /// You can use bulleted lists (use `-`, `+` or `*`):
    ///
    /// - Text can be _emphasised_
    /// - Or **strong**
    ///
    /// Or numbered lists:
    ///
    /// 7. The numbers you use make no difference
    /// 0. The list will still be ordered, starting from 1
    /// 5. But be sensible and just use 1, 2, 3 etc…
    ///
    /// ---
    ///
    /// More Stuff
    /// ==========
    ///
    /// Code
    /// ----
    ///
    /// Use backticks for inline `code()`. Indentations of 4 spaces or more will create a code block, handy for example usage:
    ///
    ///     // Create an integer, and do nothing with it
    ///     let myInt = 42
    ///     doNothing(myInt)
    ///
    ///     // Also notice that code blocks scroll horizontally instead of wrapping.
    ///
    /// Links & Images
    /// --------------
    ///
    /// Include [links](https://en.wikipedia.org/wiki/Hyperlink), and even images:
    ///
    /// ![Swift Logo](/Users/Stuart/Downloads/swift.png "The logo for the Swift programming language")
    ///
    /// - note: That "Note:" is written in bold.
    /// - requires: A basic understanding of Markdown.
    /// - seealso: `Error`, for a description of the errors that can be thrown.
    ///
    /// - parameters:
    ///   - int: A pointless `Int` parameter.
    ///   - bool: This `Bool` isn't used, but its default value is `false` anyway…
    /// - throws: A `BadLuck` error, if you're unlucky.
    /// - returns: Nothing useful.    
    
    public static func count(populations:[Int], parliamentCount: Int) -> [Int] {
        let parliamentCount: Int = parliamentCount
        let populations:[Int] = populations
        let populationCount: Int = populations.reduce(0, combine: +)
        var a = [Int](count:populations.count, repeatedValue: 0)
        
        
        for (var i:Double=1.0; i<=Double(parliamentCount); i += 1) {
            
            var tempQ = [Double]()
            
            for (index, element) in populations.enumerate() {
                let q: Double = i*Double(element)/Double(populationCount)
                
                
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
            
            a[maxQ.index] += 1
        }
        
        return a
    }
    
}
