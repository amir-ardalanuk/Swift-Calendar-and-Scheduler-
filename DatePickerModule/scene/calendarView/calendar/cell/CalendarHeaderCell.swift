//
//  CalendarHeaderCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class CalendarHeaderCell: CollectionCell {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var vwContainer: CustomView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(weekday : WeekDayEntity) {
        self.lblHeader.text = weekday.name
    }
    
    func config(theme : CalenderViewTheme.CalenderItemHeader){
        self.lblHeader.font = theme.font
        self.lblHeader.textColor = theme.textColor
        self.vwContainer.backgroundColor = theme.background
        vwContainer.setCorner(radius: theme.radius)
    }

}
