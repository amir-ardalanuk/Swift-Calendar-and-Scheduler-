//
//  GroupCalendarViewController.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/13/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class GroupCalendarViewController: UIViewController {
    
    var pageViewController : UIPageViewController!
    typealias T = GroupCalendarViewModel
    lazy var viewModel: GroupCalendarViewModel = {
        return GroupCalendarViewModel(output: self,currentDate: self.currentDate ?? Date() )
    }()
    
    weak var delegate : GroupCalendarDelegate?
    var currentDate : Date?
}

extension GroupCalendarViewController : GroupCalendarOutput {
    func updateCurrentDate(_ date: Date) {
        self.delegate?.updateDate(date)
    }
}
extension GroupCalendarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageController()
    }
}
extension GroupCalendarViewController:MainVC {
    
    func setupPageController(){
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        mine_addChild(child: pageViewController)
        let currentCalendarPage = makeCalenderInstance(viewModel.currentDate,selected: nil)
        setViewOnPageController(currentCalendarPage)
    }
    
    func setViewOnPageController(_ view:UIViewController){
        pageViewController.viewControllers?.forEach({ (view) in
            view.dismiss(animated: false) {
                print("DISMISSSED")
            }
        })
        pageViewController.setViewControllers([view], direction: .forward, animated: false)
    }
    
    private func loadNexPage(defaultSelect date : DateEntity? = nil )->UIViewController {
        let newDate = date?.date ?? viewModel.getNextMonth()
        self.viewModel.updateCurrentDate(newDate)
        return makeCalenderInstance(newDate, selected: date)
    }
    
    private func loadPrevPage(defaultSelect date : DateEntity? = nil) -> UIViewController {
        let newDate = date?.date ?? viewModel.getPrevMonth()
        self.viewModel.updateCurrentDate(newDate)
        return makeCalenderInstance(newDate, selected: date)
    }
    
    private func makeCalenderInstance(_ date:Date,selected:DateEntity? = nil) -> CalendarViewController {
        let theme = CalenderViewTheme(header: CalenderViewTheme.Header(), item: CalenderViewTheme.CalenderItem(), itemHeader: CalenderViewTheme.CalenderItemHeader())
        return CalendarViewController.instance(date, selected, theme, delegate: self)
    }
}


extension GroupCalendarViewController:CalendarViewDelegate {
    
    func selectNextMonth(_ date: DateEntity?) {
        setViewOnPageController(loadNexPage(defaultSelect: date))
    }
    
    func selectPrevMonth(_ date: DateEntity?) {
        setViewOnPageController(loadPrevPage(defaultSelect: date))
    }
    
    func selectOn(_ date: DateEntity) {
        self.viewModel.updateCurrentDate(date.date)
        
    }
    
    func next() {
        setViewOnPageController(loadNexPage())
    }
    
    func prev() {
        setViewOnPageController(loadPrevPage())
    }
}

extension GroupCalendarViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return loadPrevPage()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return loadNexPage()
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("===========//=======================")
        
        if finished,completed {
            if let currentViewController = pageViewController.viewControllers?.first as? CalendarViewController {
                self.viewModel.updateCurrentDate(currentViewController.controllerMainDate!)
            }
        }
    }
    
}
extension GroupCalendarViewController : ReusableView {
    static func instance(_ date : Date?,delegate : GroupCalendarDelegate? )->GroupCalendarViewController {
        let vc = controller(storyname: "Main") as! GroupCalendarViewController
        vc.delegate = delegate
        vc.currentDate = date
        return vc
    }
}
