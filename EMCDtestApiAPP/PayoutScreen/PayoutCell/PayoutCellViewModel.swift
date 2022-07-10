//
//  PayoutCellViewModel.swift
//  EMCDtestApiAPP
//
//  Created by v.sklyarov on 09.07.2022.
//

import Foundation
import ReactiveSwift

class PayoutCellViewModel {
    
    var date = MutableProperty("")
    var amount = MutableProperty("")
    
    init(date: String, amount: String) {
        self.date.value = date
        self.amount.value = amount
    }
    
}
