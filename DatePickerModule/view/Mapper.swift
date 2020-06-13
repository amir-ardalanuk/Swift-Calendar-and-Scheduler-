//
//  Mapper.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    func mapping(input:Input)->Output
}
