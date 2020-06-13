//
//  protocol.swift
//  DatePickerModule
//
//  Created by Amir Ardalan on 4/12/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import UIKit

protocol MainVC {
    associatedtype T:ViewModel
    var viewModel : T {get}
    
}

extension MainVC where T:ViewModel,Self:UIViewController {
    func mine_addChild(child:UIViewController){
        addChild(child)
        child.view.frame = self.view.frame
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
