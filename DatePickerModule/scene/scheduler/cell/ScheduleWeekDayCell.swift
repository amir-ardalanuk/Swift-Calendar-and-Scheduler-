//
//  ScheduleWeekDayCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ScheduleWeekDayCell: CollectionCell, ScheduleWeekCell {
   
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDayName: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(date: DateEntity, hideSideBorder: Bool) {
        self.lblDate.text = date.number
        guard let weekDate = date as? WeekDateModel else {return}
        self.lblDayName.text = weekDate.dayName
    }

}
