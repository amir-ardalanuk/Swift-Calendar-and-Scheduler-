//
//  CalendarViewProtocols.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/13/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol CalendarViewDelegate : class {
    func next()
    func prev()
    func selectNextMonth(_ date:DateEntity?)
    func selectPrevMonth(_ date:DateEntity?)
    func selectOn(_ date :DateEntity)
}

protocol CalendarViewModelOutput: ViewModelOutPut {
    func upadteList(_ list: [DateEntity])
    func updateWeekDay(_ list: [WeekDayEntity])
    func updateMonthName(title:String)
    func selectNextMonthDate(_ date : DateEntity)
    func selectPrevMonthDate(_ date : DateEntity)
    func selectOn(_ date : DateEntity)
}


protocol CalendarCellDelegate:class{
    func clickOn(_ date : DateEntity)
}


