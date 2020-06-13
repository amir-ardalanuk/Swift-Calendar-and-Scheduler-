//
//  SimpleLabel.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/14/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class SimpleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConfig()
    }
    
    func setConfig(){
        //self.textAlignment =  .right
    }
}
