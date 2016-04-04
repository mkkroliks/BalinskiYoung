//
//  PopulationCell.swift
//  BalinskiIYoung
//
//  Created by Maciej Królikowski on 05/04/16.
//  Copyright © 2016 Maciej Królikowski. All rights reserved.
//

import Cocoa

class PopulationCell: NSTableCellView, NSTextFieldDelegate, NSControlTextEditingDelegate {

    override func awakeFromNib() {
//        textField?.delegate = self
//        textField?.editable = true
    }
    
    public func textShouldBeginEditing(textObject: NSText) -> Bool {
        return true
    }
    public func textShouldEndEditing(textObject: NSText) -> Bool {
        return true
    }
    public func textDidBeginEditing(notification: NSNotification) {
        
    }
    public func textDidEndEditing(notification: NSNotification) {
        
    }
    public func textDidChange(notification: NSNotification) {
        
    }
    
    public func control(control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return true
    }
    public func control(control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        return true
    }
}
