//
//  ViewModel.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
protocol ViewModel {
    var output :ViewModelOutPut?{get}
}
extension ViewModel {
    func getOutput() -> ViewModelOutPut? {
        return output
    }
    
    
}

