//
//  DateRepository.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/11/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol AADate {
    var calendar : Calendar {get set}
    func getCurrentMonthDates(from  date : Date) -> [Date]
    
    /// get Days of next Month from date you pass
    /// - Parameters:
    ///   - date: current date
    ///   - next: how many next month *example if ypu set  1 return next month if you set 2 return next next month days*
    func getNextMonthDates(from  date : Date,next:Int?) -> [Date]
    /// get Days of previous Month from date you pass
    /// - Parameters:
    ///   - date: current date
    ///   - prev: how many previous month *example if ypu set  1 return previous month if you set 2 return previous previous month days*
    func getPreviousMonthDates(from  date : Date,prev:Int?) -> [Date]
    
    func getDatesOfPerviousMonth(from date:Date,monthPosition:Int,numberOfDays:Int)->[Date]
    
    func getDatesOfNextMonth(from date:Date,monthPosition:Int,numberOfDays:Int)->[Date]
    
    func weekDates(_ date : Date)->[Date]
    
    func lastDayOf(month date :Date) -> Date
    
    func firstDayOf(month date : Date)-> Date
    
    func weekDays()->[String]
    
    func farFromStartOfWeek(_ date :Date)->Int
    
    func farFromEndOfWeek(_ date :Date)->Int
    
    
    
    func getFirstDateOfWeek(from date : Date)->Date
    
    func getLastDateOfWeek(from date : Date)->Date
}


extension AADate {
    
    func nextDay(date: Date,next :Int = 1) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = next
        return Calendar.current.date(byAdding: dateComponents, to: date)!
    }

    func monthBy(date: Date,position:Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = position
        return Calendar.current.date(byAdding: dateComponents, to: date)!
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    func month(date : Date) -> String {
           let dateformatter = DateFormatter()
           dateformatter.dateFormat = "MMMM"
           return  dateformatter.string(from: date)
    }
    
    func month_year(date : Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM'-'yyyy"
        return  dateformatter.string(from: date)
    }
       
       func day(date : Date) -> String {
           let dateformatter = DateFormatter()
           dateformatter.dateFormat = "EEEE"
           return  dateformatter.string(from: date)
       }
     
    func shortDay(date : Date) -> String {
              let dateformatter = DateFormatter()
              dateformatter.dateFormat = "EE"
              return  dateformatter.string(from: date)
    }
}

