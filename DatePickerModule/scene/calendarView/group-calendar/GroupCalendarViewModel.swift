//
//  GroupCalendarViewModel.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/13/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol GroupCalendarOutput : ViewModelOutPut {
    func updateCurrentDate(_ date:Date)
}
class GroupCalendarViewModel:ViewModel {
    
    weak var output: ViewModelOutPut?
    var currentDate : Date!
    var repo = AADateRepository(calendar: .current)
    var currentOutPut : GroupCalendarOutput {
        return output as! GroupCalendarOutput
    }
    
    init(output:GroupCalendarOutput,currentDate:Date = Date() ) {
        self.output = output
        self.currentDate = currentDate
    }
    
    func getNextMonth()->Date{
        return repo.monthBy(date: currentDate, position: 1)
    }
    
    func getPrevMonth() -> Date{
        return repo.monthBy(date: currentDate, position: -1)
    }
    
    func updateCurrentDate(_ date : Date){
        self.currentDate = date
        self.currentOutPut.updateCurrentDate(date)
    }
    
}
