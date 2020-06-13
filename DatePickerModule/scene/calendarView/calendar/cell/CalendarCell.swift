//
//  CalendarCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class CalendarCell: CollectionCell {
    
    @IBOutlet weak var mainLbl: UILabel!
    
    var delegate:CalendarCellDelegate?
    @IBOutlet weak var vwContainer: CustomView!{
        didSet{
            self.vwContainer.tap = {[weak self]  in
                guard let _delegate = self?.delegate , let date = self?.date else {
                    return
                }
                _delegate.clickOn(date)
            }
        }
    }
    
    var date : DateEntity?
}

extension CalendarCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(date : DateEntity,theme:CalenderViewTheme.CalenderItem,delegate : CalendarCellDelegate){
        self.mainLbl.text =  date.number
        self.delegate = delegate
        self.date = date
        self.config(theme: theme, isSelected: date.selected,active: date.active)
        
    }
    
    private func config(theme : CalenderViewTheme.CalenderItem,isSelected:Bool,active: Bool){
        let textColor = isSelected ? theme.selectedColor : active ? theme.textColor : theme.deactiveColor
        self.mainLbl.textColor              = textColor
        self.mainLbl.font                   = theme.font
        self.vwContainer.backgroundColor    = isSelected ? theme.selectedBackground : theme.background
        self.vwContainer.setCorner(radius: theme.radius)
        
    }
}
