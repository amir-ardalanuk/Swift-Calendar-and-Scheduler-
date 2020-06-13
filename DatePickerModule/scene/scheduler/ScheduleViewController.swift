//
//  ScheduleViewController.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    final let _heightOfCell : CGFloat = 60
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(ScheduleHourCell.self)
            self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 10))
        }
    }
    @IBOutlet private weak var lblDateOFSchedule: UILabel!
    
    
    @IBOutlet private weak var scheduleTypeSegement: UISegmentedControl!
    
    private var scheduleDate: Date? = Date()
    private var weekdays = [WeekDateModel]()
    private var dayHours = [DailyHourModel]()
    private var weekdaysTheme = WeekBarViewTheme()
    private var mode : ScheduleViewModel.ScheduleMode = .week
    private var headerDataSource : ScheduleCollectionDataSource!
    private var itemsDataSource : ScheduleCollectionDataSource!
    
    lazy  var viewModel: ScheduleViewModel = {
        return ScheduleViewModel(date:scheduleDate!,repo: AADateRepository(calendar: .current), output: self)
    }()
    
    @IBAction  func changeSegmentValue(_ sender: Any) {
        let _title = scheduleTypeSegement.titleForSegment(at: scheduleTypeSegement.selectedSegmentIndex) ?? ""
        self.viewModel.changeMode(_title)
    }
    
}

extension ScheduleViewController: MainVC {
    
    typealias T = ScheduleViewModel
    
}

extension ScheduleViewController: ScheduleViewModelOutput {
    func updateWeekDays(_ list: [WeekDateModel]) {
        self.weekdays = list
        self.headerDataSource = ScheduleCollectionDataSource(items: list, mode: self.mode.rawValue, type: .header)
        self.itemsDataSource = ScheduleCollectionDataSource(items: list, mode: self.mode.rawValue, type: .normanl)
          self.tableView.reloadData()
    }
    
    func updateScheduleTitleDate(_ dateString: String) {
        self.lblDateOFSchedule.text = dateString
    }
    
    func updateDailyHours(_ list: [DailyHourModel]) {
        self.dayHours = list
      
    }
    
    func updateMode(_ mode: ScheduleViewModel.ScheduleMode) {
        self.mode = mode
        self.tableView.reloadData()
    }
    
}


extension ScheduleViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDailyhours()
        viewModel.getWeekDays()
    }
    
    public func updateCurrentDate(_ date : Date){
        self.viewModel.updatingScheduleDate(date)
    }
}
extension ScheduleViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return mode == .week ? 1 : 0
        case 1:
            return dayHours.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ScheduleHourCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let hourLabelWidth: CGFloat = 60
        let countOfCalendarItem: CGFloat = 7
        return ((tableView.frame.width - hourLabelWidth ) / countOfCalendarItem)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _cell = cell as? ScheduleHourCell else {
            return
        }
        switch indexPath.section {
        case 0:
            _cell.configHeader(cell: headerDataSource,daily: self.dayHours[indexPath.row], mode: self.mode.rawValue)
        default:
            _cell.config(cell: itemsDataSource,daily: self.dayHours[indexPath.row], mode: self.mode.rawValue)
        }
        
    }
}
