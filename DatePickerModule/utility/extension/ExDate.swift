//
//  ExDate.swift
//  Tarabar
//
//  Created by Amir Ardalan on 4/30/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation
extension Date
{
    var month : String {
              let dateformatter = DateFormatter()
              dateformatter.dateFormat = "MMMM"
              return  dateformatter.string(from: self)
          }
          
    var day : String {
              let dateformatter = DateFormatter()
              dateformatter.dateFormat = "EEEE"
              return  dateformatter.string(from: self)
          }
        
    var shortDay : String {
                 let dateformatter = DateFormatter()
                 dateformatter.dateFormat = "EE"
                 return  dateformatter.string(from: self)
    }
    
    var DayWithMonthShortName : String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "d MMM"
        return  dateformatter.string(from: self)
    }
    
    var dayNumber : String {
        let dateformatter = DateFormatter()
                     dateformatter.dateFormat = "dd"
                     return  dateformatter.string(from: self)
    }
    func convertToPersianWithTodayStr()->String{
        if Calendar.current.isDateInToday(self){
            return "امروز"
        }else if Calendar.current.isDateInYesterday(self){
            return "دیروز"
        }else{
            return self.convertToPersianDate()
        }
    }
    
    var convertToUTC : Date? {
        let dateFormmater:DateFormatter = DateFormatter()
        dateFormmater.timeZone = TimeZone(identifier: "UTC")
         dateFormmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let str = dateFormmater.string(from: self)
        
        return dateFormmater.date(from: str) ?? Date()
    }
    
    var convertToGMT : Date?{
        let dateFormmater:DateFormatter = DateFormatter()
        dateFormmater.timeZone = TimeZone(identifier: "GMT")
        dateFormmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let str = dateFormmater.string(from: self)
        
        return dateFormmater.date(from: str) ?? Date()
//        dateFormmater.calendar = Calendar(identifier: Calendar.Identifier.persian)
        
    }
    
    func convertToPersianDate(formatString:String?="yyyy/MM/dd") -> String
    {
        let dateFormmater:DateFormatter = DateFormatter()
        dateFormmater.calendar = Calendar(identifier: Calendar.Identifier.persian)
      //  dateFormmater.locale = Locale(identifier: "fa_IR")
      //  dateFormmater.timeZone = TimeZone(identifier: "UTC")
        
        dateFormmater.dateFormat = formatString;
        return dateFormmater.string(from: self)
    }
    
    func convertToServerFormat(formatString:String?="yyyy-MM-dd'T'HH:mm:ssZ") -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: self)
    }
    
    func  compareDaysWith(otherDate : Date )->Bool {
        
        let date1 = self
        let date2 = otherDate
        
        return Calendar.current.compare(date1, to: date2, toGranularity: .day) == .orderedSame
        
    }
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 1_000_000)
    }
    
    func validDate(With date : Date) -> Bool {
        let one = self.componenet()
        let two = date.componenet()
        guard one.y <= two.y else {
            return false
        }
        if one.y == two.y {
            guard two.m >= one.m else {
                return false
            }
            if two.m > one.m {
                return true
            }else{
                return  two.d >= one.d
            }
        }else {
            return true
        }
        
    }
    
    func componenet()-> (d: Int , m : Int , y : Int){
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return (d: day , m : month  , y : year)
    }
    
    func componenetPersian()-> (d: Int , m : Int , y : Int){
        var calendar  = Calendar(identifier: Calendar.Identifier.persian)
        calendar.locale = Locale(identifier: "fa_IR")
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return (d: day , m : month  , y : year)
    }
}

extension String
{
    func convertToEnglishDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: self) else {return nil}
        return date
    }
    
    func convertToDate(formatString:String?="yyyy-MM-dd'T'HH:mm:ssZ") -> Date?
    {
        let dateFormmater:DateFormatter = DateFormatter()
        dateFormmater.dateFormat = formatString;
        guard let date = dateFormmater.date(from: self) else
        {
            dateFormmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ";
            return dateFormmater.date(from: self)
            
        }
        return date
    }
}
