//
//  CalendarViewController.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit


class CalendarViewController: UIViewController {

    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(CalendarCell.self)
            self.collectionView.register(CalendarHeaderCell.self)
        }
    }
    
    private var collectionList = [DateEntity]()
    private var collectionHeader = [WeekDayEntity]()
    private var theme : CalenderViewTheme!
    private weak var delegate : CalendarViewDelegate?
    open var controllerMainDate : Date!
    
    lazy var viewModel: CalendarViewModel = {
        return CalendarViewModel(date: self.controllerMainDate, outPut: self, theme: theme)
    }()

}

extension CalendarViewController : CalendarViewModelOutput {
    func selectOn(_ date: DateEntity) {
        self.delegate?.selectOn(date)
    }
    
    func selectNextMonthDate(_ date: DateEntity) {
        self.delegate?.selectNextMonth(date)
    }
    
    func selectPrevMonthDate(_ date: DateEntity) {
        self.delegate?.selectPrevMonth(date)
    }
    
    func updateMonthName(title: String) {
        self.lblMonth.text = title
    }
    
    func updateWeekDay(_ list: [WeekDayEntity]) {
        self.collectionHeader = list
        self.collectionView.reloadData()
    }
    
    func upadteList(_ list: [DateEntity]) {
        self.collectionList = list
        self.collectionView.reloadData()
    }
}

extension CalendarViewController:MainVC {
    typealias T = CalendarViewModel
}

extension CalendarViewController {
    
    override func viewDidLoad() {
          super.viewDidLoad()
            self.setupView()
            self.setupTheme()
            viewModel.getCalendarCurrentMonthDate()
            viewModel.getWeekDays()
            viewModel.getMonthName()
            
      }
    
    func setupView(){
        let nextTap = UITapGestureRecognizer(target: self, action: #selector(loadNext))
        let prevTap = UITapGestureRecognizer(target: self, action: #selector(loadPrev))
        self.btnNext.addGestureRecognizer(nextTap)
        self.btnPrev.addGestureRecognizer(prevTap)
    }
    
    @objc func loadNext(){
        self.delegate?.next()
    }
    
      @objc func loadPrev(){
        self.delegate?.prev()
    }
}

extension CalendarViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return collectionHeader.count
        case 1:
            return collectionList.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell : CalendarHeaderCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.config(weekday: collectionHeader[indexPath.row])
            cell.config(theme: self.theme.itemHeader)
            return cell
        case 1:
            let cell : CalendarCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.config(date: self.collectionList[indexPath.row], theme: self.theme.item,delegate: self.viewModel)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.collectionView.frame.width / 7.5
        switch indexPath.section {
        case 0: return  CGSize(width: w, height: w / 2)
        case 1: return  CGSize(width: w, height: w)
        default:
            return CGSize.zero
        }
        
    }
    
}

extension CalendarViewController : ReusableView {
    static func instance(_ date : Date,
                         _ defaultDateSelected:DateEntity?,
                         _ theme : CalenderViewTheme,
                         delegate : CalendarViewDelegate? )->CalendarViewController {
        let vc = controller(storyname: "Main") as! CalendarViewController
        vc.controllerMainDate = date
        vc.delegate = delegate
        vc.theme = theme
        vc.viewModel.selectedDate = defaultDateSelected
        return vc
    }
}

extension CalendarViewController {
    func setupTheme(){
        self.btnNext.setTitle(self.theme.header.nextMonthText, for: btnNext.state)
        self.btnNext.tintColor = self.theme.header.nextMonthTint
        if let image = self.theme.header.nextMonthImage {
            self.btnNext.setImage(image, for: btnNext.state)
        }
        
        self.btnPrev.setTitle(self.theme.header.prevMonthText, for: btnNext.state)
        self.btnPrev.tintColor = self.theme.header.prevMonthTint
        if let image = self.theme.header.nextMonthImage {
            self.btnPrev.setImage(image, for: btnPrev.state)
        }
        
        self.lblMonth.textColor = theme.header.titleColor
        self.lblMonth.font = theme.header.font
        
    }
}
