//
//  ViewController.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 23/03/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import Cocoa
import Charts

class ViewController: NSViewController {

    @IBOutlet weak var calculationTextView: NSScrollView!
    var populations:[Double]?
    var selectedRowIndex: Int?
    
    @IBOutlet weak var parliamentCountTextField: NSTextField!
    
    @IBOutlet weak var statePopulationTextField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parliamentCount: Double = 5
        populations = [7270, 1230, 2220]
        count(populations!, parliamentCount: parliamentCount)
        
        self.tableView.reloadData()
    }
    
    func count(populations:[Double], parliamentCount: Double) -> [Double] {
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
        
        var stany = [String]()
        
        for i in 0..<populations.count {
            stany.append("Stan \(i+1)")
        }
        
        setChart(stany, values: a)
        
        return a
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Rozmieszczenie miejsc w par")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        chartView.data = pieChartData
        
        var colors: [NSUIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = NSUIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
    }

    
    @IBAction func plusButtonAction(sender: AnyObject) {
        populations?.append(0)
        tableView.reloadData()
    }
    @IBAction func minueButtonAction(sender: AnyObject) {
        if tableView.selectedRow != -1 {
            populations?.removeAtIndex(tableView.selectedRow)
            tableView.reloadData()
        }
    }
    
    
    @IBAction func addState(sender: AnyObject) {
        let stringValue = statePopulationTextField.stringValue
        if  stringValue != "" {
            if let doubleValue = Double(stringValue) {
                populations?.append(doubleValue)
                tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func countAction(sender: AnyObject) {
        let stringValue = parliamentCountTextField.stringValue
        
        if let doubleValue = Double(stringValue), populations = populations where stringValue != "" {
            count(populations, parliamentCount: doubleValue)
        }
    }
    
}

extension ViewController: NSTextFieldDelegate {
    
    func textShouldBeginEditing(textObject: NSText) -> Bool {
        return true
    }
    func textShouldEndEditing(textObject: NSText) -> Bool {
        return true
    }
    func textDidBeginEditing(notification: NSNotification) {
        
    }
    func textDidEndEditing(notification: NSNotification) {
        
    }
    func textDidChange(notification: NSNotification) {
        
    }
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return populations?.count ?? 0
    }
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        guard let item = populations?[row] else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            text = "Stan \(row+1)"
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = String(item)
            cellIdentifier = "ValueCellID"
        }
        
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.textField?.delegate = self
            return cell
        }
        return nil
    }
    
}



