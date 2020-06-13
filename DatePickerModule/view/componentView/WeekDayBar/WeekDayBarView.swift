//
//  WeekDayBarView.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
struct WeekBarViewTheme {
    var back_color : UIColor = .white
    var label_color : UIColor = .black
    var label_back_color : UIColor = .white
    var label_font = UIFont.systemFont(ofSize: 12)
    var seprator_distance : CGFloat = 4
    var boarder_radius : CGFloat = 0
    var border_color : UIColor = .white
    
}
class WeekDayBarView: UIView ,Connectable{
    
    @IBOutlet weak var stackview : UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup(){
        self.commit()
    }
    
    func setItem<T:CustomStringConvertible>(list : [T],theme : WeekBarViewTheme){
        list.forEach { (item) in
            let label = UILabel()
            label.text = String(describing: item)
            label.textColor = theme.label_color
            label.font = theme.label_font
            label.backgroundColor = theme.label_back_color
            self.stackview.addArrangedSubview(label)
        }
    }
    
    
}
