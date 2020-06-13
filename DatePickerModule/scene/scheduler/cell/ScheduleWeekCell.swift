//
//  ScheduleWeekCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/16/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
protocol ScheduleWeekCell : CollectionCell {
    func config(date:DateEntity, hideSideBorder :Bool)
}
