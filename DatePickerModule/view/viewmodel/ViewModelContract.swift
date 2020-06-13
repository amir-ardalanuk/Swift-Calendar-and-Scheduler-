//
//  ViewModelContract.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
protocol ViewModelContract {
    func loading(state : Bool)
    func error(message : String)
    func reload()
}
