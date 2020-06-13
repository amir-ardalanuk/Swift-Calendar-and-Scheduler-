//
//  DateEntity.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
protocol DateEntity {
    var number:String{get}
    var date :Date{get set}
    var active:Bool{get set}
    var selected:Bool{get set}
}

struct WeekDateModel:DateEntity {
    var number: String {
        return date.dayNumber
    }
    
    var date: Date
    
    var active: Bool = false
    
    var selected: Bool = false
    
    var dayName:String {
        return date.shortDay
    }
    
    
    
}
struct DateModel : DateEntity {
    
    var date: Date
    var active: Bool
    var selected:Bool = false
    
    var number: String {
        return date.dayNumber
    }
}

struct AroundDateModel : DateEntity {
    
    var date: Date
    var active: Bool
    var selected:Bool = false
    var number: String {
        return date.dayNumber
    }
}


