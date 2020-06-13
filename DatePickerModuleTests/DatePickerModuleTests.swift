//
//  DatePickerModuleTests.swift
//  DatePickerModuleTests
//
//  Created by Amir Ardalan on 4/11/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import XCTest
@testable import DatePickerModule

class DatePickerModuleTests: XCTestCase {

    var dateRepo : AADate!
    override func setUp() {
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        dateRepo = AADateRepository(calendar: calender)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_getFirstDateOfMonth_nameOfMonth(){
        
        let date = dateByString(str: "2020-04-11")
        let test = dateRepo.firstDayOf(month: date)
        
        let month = dateRepo.month(date: test)
        
        XCTAssertTrue(month == "April", "same ")
        
    }
    
    func test_getFirstDateOfMonth_nameOfDay(){
           
           let date = dateByString(str: "2020-04-11")
           let test = dateRepo.firstDayOf(month: date)
           let day = dateRepo.shortDay(date: test)

           XCTAssertTrue(day == "Wed", "same ")
           
       }
    
    func test_getCurrentMonthDates_isNotEmply(){
            let date = dateByString(str: "2020-04-11")
           let items = dateRepo.getNextMonthDates(from: date, next: 1)
            XCTAssertFalse(items.isEmpty)
           
       }
    func test_getNextMonthDates_nextMonthFirstDayName_istrue(){
         let date = dateByString(str: "2020-04-11")
        let items = dateRepo.getNextMonthDates(from: date, next: 1)
        let name = dateRepo.shortDay(date: items.first!)
         XCTAssertEqual("Fri", name)
    }
    
    func test_getCurrentMonthDates_FirstDayName_true(){
         let date = dateByString(str: "2020-04-11")
        let items = dateRepo.getCurrentMonthDates(from: date)
        let name = dateRepo.shortDay(date: items.first!)
         XCTAssertEqual("Wed", name)
    }
    
    func test_getPreviousMonthDates_FirstDayName_true(){
            let date = dateByString(str: "2020-04-11")
           let items = dateRepo.getPreviousMonthDates(from: date, prev: nil)
           let name = dateRepo.shortDay(date: items.first!)
            XCTAssertEqual("Sun", name)
    }
    
    func test_numberOfDayInWeek() {
        let date = dateByString(str: "2020-04-01")
        let items = dateRepo.farFromStartOfWeek(date)
        XCTAssertEqual(4,items)
    }
    
    func test_farFromEndOfWeek_distanceFromEndOfWeek() {
        let date = dateByString(str: "2020-04-01")
        let items = dateRepo.farFromEndOfWeek(date)
        XCTAssertEqual(3,items)
    }
    
    func test_getDatesOfPerviousMonth_checkWithFirstDayOfMonth() {
        let date = dateByString(str: "2020-04-01").toLocalTime()
        let far = dateRepo.farFromStartOfWeek(date)
        let dateFar = dateRepo.getDatesOfPerviousMonth(from: date, monthPosition: 1, numberOfDays: far - 1 )
        XCTAssertEqual("2020-03-29",dateToString(date: dateFar.last!))
    }

    func test_getDatesOfNextMonth_checkWithFirstDayOfMonth() {
           let date = dateByString(str: "2020-04-01").toLocalTime()
           let far = dateRepo.farFromEndOfWeek(date)
           let dateFar = dateRepo.getDatesOfNextMonth(from: date, monthPosition: 1, numberOfDays: far - 1 )
           XCTAssertEqual("2020-05-02",dateToString(date: dateFar.last!))
    }
    
    func test_getFirstDayOfWeek(){
        let date = dateByString(str: "2020-04-01 00:00",withFormat: "yyyy-MM-dd HH:mm")
        let firstDateOfWeek  = dateRepo.getFirstDateOfWeek(from: date).toGlobalTime()
        XCTAssertTrue(dateToString(date: firstDateOfWeek) == "2020-03-29" )
    }
    
    func test_getLastDayOfWeek(){
        let date = dateByString(str: "2020-04-01 00:00",withFormat: "yyyy-MM-dd HH:mm")
        let firstDateOfWeek  = dateRepo.getLastDateOfWeek(from: date).toGlobalTime()
        XCTAssertTrue(dateToString(date: firstDateOfWeek) == "2020-04-04" )
    }
    
    func test_weekDates_return7DateOfWeek_checkfirstDate(){
           let date = dateByString(str: "2020-04-01 00:00",withFormat: "yyyy-MM-dd HH:mm")
           let dateOfWeek  = dateRepo.weekDates(date)
            let firstDateString = dateToString(date: dateOfWeek.first!)
        let lastDateString = dateToString(date: dateOfWeek.last!)
        
        //XCTAssertTrue( firstDateString == "2020-03-29" )
        XCTAssertTrue( lastDateString == "2020-04-04" )
       }

    func dateByString(str:String,withFormat : String = "yyyy-MM-dd") -> Date {
        let df = DateFormatter()
        df.dateFormat = withFormat
        df.timeZone = TimeZone.current
        return df.date(from: str)!
    }
    
    func dateToString(date:Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date)
    }
}

