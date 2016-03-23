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
    
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

