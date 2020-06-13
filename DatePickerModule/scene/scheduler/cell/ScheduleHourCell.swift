//
//  ScheduleHourCell.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ScheduleHourCell: TableCell {

    enum ScheduleHourMode : String {
        case week = "Week"
        case day = "Day"
    }
    @IBOutlet weak var lblHourSeprator: UIView!
    @IBOutlet weak var vwTopSeprator: UIView!
    @IBOutlet weak var hourContainer: UIStackView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
            didSet{
                self.collectionView.register(ScheduleDailyHourCell.self)
                self.collectionView.register(ScheduleWeekDayCell.self)
            }
    }
    
    private var collectionWidth : CGFloat {
        return collectionView.frame.width
    }
    
    public var rowHeight : CGFloat {
        return (collectionView.frame.width / 7) + 11
    }
    private var collectionHeight : CGFloat {
        return collectionView.frame.height
    }
    
    private var mode : ScheduleHourMode!
}

extension ScheduleHourCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(cell:ScheduleCollectionDataSource,daily : DailyHourModel, mode: String){
        self.lblHourSeprator.backgroundColor = .white
        self.vwTopSeprator.backgroundColor = .white
        self.lblHour.text = "\(daily.hour)\(daily.sign)"
        self.mode = ScheduleHourMode(rawValue: mode)
        setcollcetionData(cell)
    }
    
    fileprivate func setcollcetionData(_ cell: ScheduleCollectionDataSource) {
        self.collectionView.dataSource = cell
        self.collectionView.delegate = cell
        self.collectionView.reloadData()
    }
    
    func configHeader(cell:ScheduleCollectionDataSource,daily : DailyHourModel, mode: String){
        
        self.lblHourSeprator.backgroundColor = .clear
        self.vwTopSeprator.backgroundColor = .clear
        self.lblHour.text = ""
        self.mode = ScheduleHourMode(rawValue: mode)
        setcollcetionData(cell)
    }
}
