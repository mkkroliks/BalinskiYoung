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
    var populations:[Int]?
    var selectedRowIndex: Int?
    
    @IBOutlet weak var parliamentCountTextField: NSTextField!
    
    @IBOutlet weak var statePopulationTextField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populations = []
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Rozmieszczenie miejsc w parlamencie")
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
        let parliamentCountStringValue = parliamentCountTextField.stringValue
        
        
        if tableView.selectedRow != -1 {
            populations?.removeAtIndex(tableView.selectedRow)
            tableView.reloadData()
        }
        
        if parliamentCountStringValue != "" {
            if let parliamentCount = Int(parliamentCountStringValue) {
                    reloadChart(populations!, parliamentCount: parliamentCount)
            }
        }
    }
    
    
    @IBAction func addState(sender: AnyObject) {
        let statePopulationStringValue = statePopulationTextField.stringValue
        let parliamentCountStringValue = parliamentCountTextField.stringValue
        
        if  statePopulationStringValue != "" {
            if let statePopulationValue = Int(statePopulationStringValue) {
                populations?.append(statePopulationValue)
                tableView.reloadData()
                if parliamentCountStringValue != "" {
                    if let parliamentCount = Int(parliamentCountStringValue) {
                        reloadChart(populations!, parliamentCount: parliamentCount)
                    }
                }
            }
        }
    }
    
    
    @IBAction func countAction(sender: AnyObject) {
        let stringValue = parliamentCountTextField.stringValue
        
        if let parliamentCount = Int(stringValue), populations = populations where stringValue != "" {
            reloadChart(populations, parliamentCount: parliamentCount)
            self.tableView.reloadData()
        }
    }
    
    private func reloadChart(populations: [Int], parliamentCount: Int) {
        
        let a = BalinskiYoungAlgorith.count(populations, parliamentCount: parliamentCount)
        var stany = [String]()
        
        for i in 0..<populations.count {
            stany.append("Stan \(i+1)")
        }
        
        setChart(stany, values: a)
    }
    
    @IBAction func openFile(sender: AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.beginWithCompletionHandler { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                do {
                    let textContent = try String(contentsOfURL: openPanel.URL!, encoding: NSUTF8StringEncoding)
                    
                    let valuesArray = textContent.componentsSeparatedByString("\n")
                    
                    let statesNrAndParliamentNr = valuesArray[0].componentsSeparatedByString(" ")
                    
                    let statesValues = valuesArray[1].componentsSeparatedByString(" ")
                    
                    self.populations = []
                    
                    print(statesNrAndParliamentNr)
                    print(valuesArray)
                    
                    for stateValue in statesValues {
                        guard let stateDoubleValue = Int(stateValue) else {
                            self.displayErrorMessage("Zły format danych")
                            return
                        }
                        self.populations?.append(stateDoubleValue)
                    }
                    
                    guard let parliamentCount = Int(statesNrAndParliamentNr[1]) else {
                        self.displayErrorMessage("Zły format danych")
                        return
                    }
                    
                    self.parliamentCountTextField.stringValue = statesNrAndParliamentNr[1]
                    
                    self.tableView.reloadData()
                    self.reloadChart(self.populations!, parliamentCount: parliamentCount)
                    
                } catch let error as NSError {
                    print("error loading from url \(openPanel.URL!)")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func displayErrorMessage(message: String) {
        let alert = NSAlert()
        alert.alertStyle = .CriticalAlertStyle
        alert.messageText = "Bląd!"
        alert.informativeText = message
        alert.runModal()
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
            return cell
        }
        return nil
    }
    
}



