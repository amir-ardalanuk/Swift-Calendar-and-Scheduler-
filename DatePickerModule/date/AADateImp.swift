//
//  AADate.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/11/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
class AADateRepository:AADate {
    
    
    
    
    
    var calendar: Calendar
    
    func getNextMonthDates(from date: Date, next: Int?) -> [Date] {
        return returnDaysOfMonth(date: monthBy(date: date,position: next ?? 1))
    }
    
    func getPreviousMonthDates(from date: Date, prev: Int?) -> [Date] {
        return returnDaysOfMonth(date: monthBy(date: date,position: (prev ?? 1) * -1 ))
    }
    
    
    
    init(calendar:Calendar) {
        self.calendar = calendar
    }
    
    
    func getCurrentMonthDates(from date: Date) -> [Date] {
        return returnDaysOfMonth(date: date)
    }
    
    func returnDaysOfMonth(date : Date) -> [Date] {
        let firstDay = firstDayOf(month: date)
        let lastDay = lastDayOf(month: date)
        var from = firstDay
        var listOfdays = [Date]()
        while from <= lastDay {
            listOfdays.append(from)
            from = Calendar.current.date(byAdding: .day, value: 1, to: from)!
        }
        return listOfdays
    }
    
    
    func firstDayOf(month date : Date)-> Date {
        let _date = Calendar.current.startOfDay(for: date)
        let components = Calendar.current.dateComponents([.year,.month], from: _date)
        
        let start = calendar.date(from: components)
        return start!
        
    }
    
    func lastDayOf(month date: Date) -> Date{
        
        var component = DateComponents()
        component.month = 1
        component.day = -1
        let firstDayOfMonth = firstDayOf(month: date)
        
        let endOfMonth = calendar.date(byAdding: component, to: firstDayOfMonth)
        return endOfMonth!
    }
    
    func farFromStartOfWeek(_ date :Date) -> Int {
        let _date = Calendar.current.startOfDay(for: date)
        let components = Calendar.current.dateComponents([.weekday], from: _date)
        return components.weekday!
    }
    
    func farFromEndOfWeek(_ date: Date) -> Int {
        return 7 - farFromStartOfWeek(date)
    }
    
    func weekDays() -> [String] {
        calendar.shortStandaloneWeekdaySymbols
    }
    
    /// get Date of month with Posistion
    /// - Parameters:
    ///   - date: from date
    ///   - monthPosition: how many month next or past if is negative go to past if positive go next month
    ///   - numberOfDays: how many number of date's from month position do you need
    func getDatesOfPerviousMonth(from date:Date,monthPosition: Int, numberOfDays: Int) -> [Date] {
        var lastDayOfLastMonth = lastDayOf(month: monthBy(date: date.toLocalTime(), position: monthPosition * -1)).toLocalTime()
        var dateList = [Date]()
        dateList.append(lastDayOfLastMonth)
        var start = 1
        
        while start < numberOfDays {
            let nDate = Calendar.current.date(byAdding: .day, value: -1 , to: lastDayOfLastMonth)
            dateList.append(nDate!)
            lastDayOfLastMonth = nDate!
            start += 1
        }
        return dateList
    }
    
    /// get Date of month with Posistion
    /// - Parameters:
    ///   - date: from date
    ///   - monthPosition: how many month next or past if is negative go to past if positive go next month
    ///   - numberOfDays: how many number of date's from month position do you need
    ///   - goPast: if date is 1-1-2020 and it's true get 29-12-2019 if it's false get 2-1-2020
    func getDatesOfNextMonth(from date: Date, monthPosition: Int, numberOfDays: Int) -> [Date] {
        var lastDayOfLastMonth = firstDayOf(month: monthBy(date: date.toLocalTime(), position: monthPosition)).toLocalTime()
        var dateList = [Date]()
        dateList.append(lastDayOfLastMonth)
        var start = 1
        
        while start < numberOfDays {
            let nDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDayOfLastMonth)
            dateList.append(nDate!)
            lastDayOfLastMonth = nDate!
            start += 1
        }
        return dateList
    }
    
    func getFirstDateOfWeek(from date: Date) -> Date {
        
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        return calendar.date(byAdding: .day, value: 1, to: sunday!)!.toGlobalTime()
    }
    
    func getLastDateOfWeek(from date: Date) -> Date {
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        return calendar.date(byAdding: .day, value: 7, to: sunday!)!.toGlobalTime()
    }
    
    func weekDates(_ date: Date) -> [Date] {
        var first = self.getFirstDateOfWeek(from: date)
        var list = [Date]()
        list.append(first)
        var count = 1
        while count < 7 {
            let nextDay = self.calendar.date(byAdding: .day, value: 1, to: first)
            list.append(nextDay!)
            first = nextDay!
            count += 1
        }
        return list
    }
}

extension Date {
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getNight()->Date{
        return Calendar.current.date(bySetting: .hour, value: 0, of: self)!
    }
}
