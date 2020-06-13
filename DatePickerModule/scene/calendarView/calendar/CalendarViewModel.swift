//
//  CalendarViewModel.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation



class CalendarViewModel: ViewModel {
  
    var repo : AADate!
    weak var output: ViewModelOutPut?
    var date : Date
    var selectedDate:DateEntity?
    var prevMonth = [Date]()
    var nextMonth = [Date]()
    var theme : CalenderViewTheme
    lazy var currentOutput : CalendarViewModelOutput = {
        return output as! CalendarViewModelOutput
    }()
    
    init(date:Date,outPut:CalendarViewModelOutput,theme : CalenderViewTheme) {
        repo = AADateRepository(calendar: Calendar.current)
        self.output = outPut
        self.date = date
        self.theme = theme
    }
    
    func getCalendarCurrentMonthDate(){
        let current = repo.getCurrentMonthDates(from: date).map{
            DateModel(date: $0,
                      active: true,
                      selected: $0.compareDaysWith(otherDate: (self.selectedDate?.date ?? date)))
        }
        
        let previousDaysBeforeStartOfMonth = previousMonthDaysInCurrentMonthCome(date: current.first!.date)
            .map{
                AroundDateModel(date: $0,
                                active: false)
        }
        
        let nextDaysAfterEndOfMonth = nextMonthDaysInCurrentMonthCome(date: current.last!.date).map{
            AroundDateModel(date:$0,
                            active:false)
        }
        
        let list : [DateEntity] = (previousDaysBeforeStartOfMonth + current) + nextDaysAfterEndOfMonth
        currentOutput.upadteList( list )
    }
    
    func getMonthName(){
        
        currentOutput.updateMonthName(title: repo.month_year(date: date))
    }
    
    func previousMonthDaysInCurrentMonthCome(date:Date)->[Date] {
        guard prevMonth.isEmpty else {
            return prevMonth
        }
        let farFromStartOfWeek = repo.farFromStartOfWeek(date)
        prevMonth = repo.getDatesOfPerviousMonth(from:date , monthPosition: 1, numberOfDays: farFromStartOfWeek - 1).reversed()
        return prevMonth
    }
    
    func nextMonthDaysInCurrentMonthCome(date:Date)->[Date] {
        guard nextMonth.isEmpty else {
            return nextMonth
        }
        let farFromStartOfWeek = repo.farFromEndOfWeek(date)
        nextMonth = repo.getDatesOfNextMonth(from:date , monthPosition: 1, numberOfDays: farFromStartOfWeek)
        return nextMonth
    }
    
    func getWeekDays(){
        let data = repo.weekDays().map{WeekDayEntity(name:$0)}
        currentOutput.updateWeekDay(data)
    }
    
    func updateSelected(){
        guard let strongDate = self.selectedDate else {return}
        if prevMonth.isEmpty == false && strongDate.date <= prevMonth.last!  { /// Prev month Selected
            self.clickOnPrevMonthDate()
            return
        }
        if nextMonth.isEmpty == false && strongDate.date >= nextMonth.first! {
            self.clickOnNextMonthDate()
            return
        }
        
        self.onCurrentMonthDate()
        
    }
    
    func clickOnPrevMonthDate(){
        guard let _selectedDate = self.selectedDate else {return}
        self.currentOutput.selectPrevMonthDate(_selectedDate)
    }
    
    func clickOnNextMonthDate(){
        guard let _selectedDate = self.selectedDate else {return}
        self.currentOutput.selectNextMonthDate(_selectedDate)
    }
    
    func onCurrentMonthDate(){
        getCalendarCurrentMonthDate()
    }
}

extension CalendarViewModel : CalendarCellDelegate {
    func clickOn(_ date: DateEntity) {
        self.selectedDate = date
        self.updateSelected()
        self.currentOutput.selectOn(date)
    }
    
    
}
