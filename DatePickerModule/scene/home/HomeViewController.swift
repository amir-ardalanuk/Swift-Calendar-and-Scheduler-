//
//  HomeViewController.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/15/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    
    var calendarController : GroupCalendarViewController!{
        didSet{
            self.calendarController.delegate = self
        }
    }
    
    var scheduleController : ScheduleViewController!
}

extension HomeViewController {
    override func viewDidLoad() {
         super.viewDidLoad()
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.destination {
        case let vc as GroupCalendarViewController :
            self.calendarController = vc
        case let vc2 as ScheduleViewController:
            self.scheduleController = vc2
        default:break
        }
    }

}

extension HomeViewController: GroupCalendarDelegate {
    func updateDate(_ date: Date) {
        self.scheduleController.updateCurrentDate(date)
    }
    
    
}
