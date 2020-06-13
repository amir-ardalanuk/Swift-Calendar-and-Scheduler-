//
//  ScheduleDailyHourDataSource.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/16/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ScheduleCollectionDataSource :NSObject, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    enum ScheduleMode :String {
        case week = "Week"
        case day = "Day"
    }
    
    enum ScheduleType {
        case header
        case normanl
    }
    
    
    var mode : ScheduleMode
    var type : ScheduleType
    var items : [DateEntity]
    
    init(items : [DateEntity], mode:String,type:ScheduleType) {
        self.items = items
        self.mode = ScheduleMode(rawValue:mode) ?? .day
        self.type = type
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count//mode == .day ? 1 : 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .header:
            let cell : ScheduleWeekDayCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.config(date: items[indexPath.row], hideSideBorder: mode == .day)
            return cell
        case .normanl:
            let cell : ScheduleDailyHourCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.config(date: items[indexPath.row], hideSideBorder: mode == .day)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let cellWidth :CGFloat = self.mode == .day ? collectionWidth : collectionWidth / 7
        return CGSize(width: cellWidth , height: cellWidth)
    }
}
