//
//  ScheduleDailyHourCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ScheduleDailyHourCell: CollectionCell, ScheduleWeekCell {
}

extension ScheduleDailyHourCell {
    
    func config(date:DateEntity, hideSideBorder :Bool){
        setSideborderHide(hide: hideSideBorder)
    }
    
    func setSideborderHide(hide :Bool){
        self.contentView.subviews.first?.subviews.filter{$0.tag < 0}.forEach { (sideViews) in
            sideViews.isHidden = hide
        }
    }
}
