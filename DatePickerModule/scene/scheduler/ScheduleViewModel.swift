//
//  ScheduleViewModel.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol ScheduleViewModelOutput : ViewModelOutPut {
    func updateWeekDays(_ list:[WeekDateModel])
    func updateDailyHours(_ list: [DailyHourModel])
    func updateMode(_ mode : ScheduleViewModel.ScheduleMode)
    func updateScheduleTitleDate(_ dateString:String)
}

class ScheduleViewModel:ViewModel {
    
    public enum ScheduleMode : String {
        case week = "Week"
        case day = "Day"
    }
    
    weak var output: ViewModelOutPut?
    var repo : AADate!
    var mode : ScheduleMode! = .day
    var scheduleDate :Date
    var currentOutput : ScheduleViewModelOutput {
        return output as! ScheduleViewModelOutput
    }
    
    init(date:Date,repo:AADate,output:ScheduleViewModelOutput) {
        self.output = output
        self.scheduleDate = date
        self.repo = repo
    }
}

extension ScheduleViewModel {
    
    func changeMode(_ new: String){
        mode = ScheduleMode(rawValue: new)
        updateMode()
    }
    
    func getWeekDays() {
        if mode == .week {
            currentOutput.updateWeekDays(
                repo.weekDates(self.scheduleDate).map{ WeekDateModel(date: $0) }
            )
        }else{
            currentOutput.updateWeekDays(
                [scheduleDate].map{ WeekDateModel(date: $0) }
            )
        }
        
    }
    
    func getDailyhours()  {
        currentOutput.updateDailyHours(dailyHour(by: "am", range: 7...12) + dailyHour(by:"pm", range: 0...10))
    }
    
    func updateMode(){
        currentOutput.updateMode(mode)
        getWeekDays()
        updateTitleSchedule()
    }
    
    private func dailyHour(by sign:String,range : ClosedRange<Int>)->[DailyHourModel]{
        return Array(range).map{ DailyHourModel(hour: $0, sign: sign)}
    }
    
    func updateTitleSchedule(){
        let title : String = self.mode == .week ? getWeekTitle() : getDailyTitle()
        self.currentOutput.updateScheduleTitleDate(title)
    }
    
    private func getDailyTitle()->String {
        return scheduleDate.DayWithMonthShortName
    }
    
    private func getWeekTitle()->String {
        let firstDateOfWeek = repo.getFirstDateOfWeek(from: scheduleDate).DayWithMonthShortName
        let lastDateOfWeek = repo.getLastDateOfWeek(from: scheduleDate).DayWithMonthShortName
        return "\(firstDateOfWeek),\(lastDateOfWeek)"
    }
    
    func updatingScheduleDate(_ date : Date){
        self.scheduleDate = date
        self.getWeekDays()
        self.updateMode()
        
    }
}

