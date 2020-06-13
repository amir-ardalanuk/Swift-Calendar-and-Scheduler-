//
//  File.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/16/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

struct CalenderViewTheme {
    struct Header {
        enum HeaderTitleType {
            case month
            case month_year
        }
        
        var titleTitleType : HeaderTitleType = .month
        var titleColor : UIColor = .white
        var nextMonthText : String = ">"
        var prevMonthText : String = "<"
        var nextMonthImage : UIImage? = nil
        var prevMonthImage : UIImage? = nil
        var nextMonthTint : UIColor = .white
        var prevMonthTint : UIColor = .white
        var backgroundColor : UIColor = .clear
        var font : UIFont = UIFont.systemFont(ofSize: 12)
    }
    
    public struct CalenderItem {
        var background : UIColor = .black
        var textColor  : UIColor  = .white
        var font : UIFont = UIFont.systemFont(ofSize: 12)
        var selectedColor : UIColor = .black
        var selectedBackground : UIColor = .white
        var radius : CGFloat = 4
        var deactiveColor : UIColor = .lightGray
    }
    
    struct CalenderItemHeader {
           var background : UIColor = .black
           var textColor  : UIColor  = .white
           var font : UIFont = UIFont.systemFont(ofSize: 12)
           var selectedColor : UIColor = .red
           var selectedBackground : UIColor = .blue
           var radius : CGFloat = 0.0
       }
    
    var header : Header
    var item : CalenderItem
    var itemHeader : CalenderItemHeader
}
